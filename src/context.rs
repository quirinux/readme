// > Handlebar VM context
use pathdiff::diff_paths;
use regex::Regex;
use serde::Serialize;
use std::io::ErrorKind;

// > Default comment regex: r"^(\s|\t)*(#|//)\s?>"
// >
const PATTERN: &str = r"^(\s|\t)*(#|//)\s?>\s?";
// > Default embedded template [../templates/default.hbs](../templates/default.hbs)
// >
const TEMPLATE: &str = std::include_str!("../templates/default.hbs");
use std::{
    fs::File,
    io::{BufRead, BufReader},
    path::{Path, PathBuf},
};

// > Each matching file is registered internaly like an item as follows and all of them are made avialable on vm context:
// >
#[derive(Debug, Default, Serialize)]
pub struct Item {
    // > - absolute: handles the absolute file path
    absolute: PathBuf,
    // > - relative: handles the file relative path to pwd
    relative: PathBuf,
    // > - content: file content itself
    content: Vec<String>,
}
// >
fn new_item(absolute: PathBuf, relative: PathBuf) -> Item {
    Item {
        absolute,
        relative,
        content: vec![],
    }
}

impl Item {
    pub fn load_content(&mut self, pattern: &Regex) -> std::io::Result<Option<()>> {
        let mut _return = None;
        let _file = File::open(&self.absolute)?;
        let reader = BufReader::new(_file);
        for line in reader.lines() {
            let _line = match line {
                Ok(l) => l,
                Err(e) => match e.kind() {
                    ErrorKind::InvalidData => return Ok(None),
                    other_error => panic!("{:?}", other_error),
                },
            };
            if pattern.is_match(_line.as_str()) {
                _return = Some(());
                let _comment = pattern.replace(_line.as_str(), "");
                if _comment.len() > 0 {
                    self.content.push(_comment.to_string());
                } else {
                    self.content.push("\n".to_string());
                }
            }
        }
        Ok(_return)
    }
}

// CONTEXT
#[derive(Debug, Default)]
pub struct Context {
    root: PathBuf,
    pattern: Option<Regex>,
    pub template: String,
    pub items: Vec<Item>,
}

pub fn new(root: PathBuf) -> Context {
    Context {
        root,
        pattern: Some(Regex::new(PATTERN).unwrap()),
        template: TEMPLATE.to_string(),
        items: vec![],
    }
}

impl Context {
    pub fn add_item(&mut self, absolute: &Path) -> std::io::Result<()> {
        let _relative = diff_paths(absolute, &self.root).unwrap_or(absolute.clone().to_path_buf());
        let mut _item = new_item(absolute.to_path_buf(), _relative);
        if let Some(()) = _item.load_content(self.pattern.as_ref().unwrap())? {
            self.items.push(_item);
        }
        Ok(())
    }
}
