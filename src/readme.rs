use crate::context;
use clap::Parser;
use handlebars::{handlebars_helper, Handlebars};
use serde_json::json;
use std::default::Default;
use std::env;
use std::error;
use std::io::Read;
use std::path::PathBuf;
use std::{fs::File, io::BufReader};
use walkdir::{DirEntry, WalkDir};

type ResultHelper = Result<String, Box<dyn error::Error>>;

handlebars_helper!(join: |x: Vec<String>, { with: str = "\n" }| x.join(with));
handlebars_helper!(include: |path: PathBuf | {
    let _file = File::open(&path)?;
    let mut _reader = BufReader::new(_file);
    let mut _content = String::new();
    _reader.read_to_string(&mut _content)?;
    _content
});

#[derive(Parser, Debug, Default)]
#[clap(author, version, about)]
pub struct Readme {
    #[clap(short, long, value_parser, help = "Handlebars template file")]
    template: Option<PathBuf>,
    #[clap(
        short,
        long,
        value_parser,
        help = "whether or not to look for files recursively"
    )]
    no_recursive: bool,
    #[clap(
        short,
        long,
        value_parser,
        help = "file types to filter by in a regex pattern"
    )]
    file_type: Option<String>,
    #[clap(short, long, value_parser, help = "prints context and exit")]
    show_context: bool,

    path: Option<PathBuf>,

    #[clap(skip)]
    context: Option<crate::context::Context>,
}

pub fn new() -> Readme {
    Readme::parse()
}

impl Readme {
    fn should_pickup(&self, entry: &DirEntry) -> bool {
        if entry.file_type().is_file() {
            true
        } else {
            false
        }
    }

    pub fn load_context(&mut self) -> Result<(), Box<dyn error::Error>> {
        let _path = match self.path.clone() {
            Some(p) => p,
            None => PathBuf::from(env::current_dir()?),
        };
        let mut _context = context::new(_path.clone());
        if let Some(t) = &self.template {
            let _file = File::open(&t)?;
            let mut _reader = BufReader::new(_file);
            _context.template.clear();
            _reader.read_to_string(&mut _context.template)?;
        }
        for w in WalkDir::new(_path.clone())
            .follow_links(true)
            .into_iter()
            .filter_map(|e| e.ok())
        {
            if self.should_pickup(&w) {
                _context.add_item(w.path())?;
            }
        }
        self.context = Some(_context);
        Ok(())
    }
    pub fn process(&self) -> ResultHelper {
        if self.show_context {
            return self.show_context();
        }
        self.render()
    }

    fn show_context(&self) -> ResultHelper {
        Ok(format!("{:#?}", self.context))
    }

    fn render(&self) -> ResultHelper {
        let _context = self.context.as_ref().unwrap();
        let _files = &_context.items;
        let _template = match self.template.clone() {
            Some(t) => t.to_str().unwrap_or("not found").to_string(),
            None => "default".to_string(),
        };
        let _data = json!({ "files": &_files });
        let mut _vm = Handlebars::new();
        _vm.register_helper("join", Box::new(join));
        _vm.register_helper("include", Box::new(include));
        _vm.register_template_string(_template.as_str(), &_context.template)?;
        Ok(_vm.render(_template.as_str(), &_data)?)
    }
}
