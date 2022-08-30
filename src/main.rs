// > This is the entry point
// >
use std::error;

mod context;
mod readme;
fn main() -> Result<(), Box<dyn error::Error>> {
    let mut r = readme::new();
    r.load_context()?;
    match r.process() {
        Ok(s) => println!("{}", s),
        // > TODO: a better error handling is fairly much appreciated showing more about templating and parsing error them rust display trait
        Err(e) => {
            if let Some(s) = e.source() {
                println!("{}", s);
            } else {
                println!("{:#?}", e);
            }
            std::process::exit(1);
        }
    }
    Ok(())
}
