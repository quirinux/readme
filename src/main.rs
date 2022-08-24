use std::error;

mod context;
mod readme;
fn main() -> Result<(), Box<dyn error::Error>> {
    let mut r = readme::new();
    r.load_context()?;
    match r.process() {
        Ok(s) => println!("{}", s),
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
