use ::std::io;
use ::std::io::prelude;
use morse::phrase_to_morse;
use std::fmt::Error;
use std::fs::File;
use std::io::Read;
use std::process::exit;
use structopt::StructOpt;

#[derive(StructOpt, Debug)]
#[structopt(name = "morse_code")]
struct Opt {
    #[structopt(
        name = "input",
        short,
        long,
        required_unless("infile"),
        help("Input string to be translated. Single line only.")
    )]
    input: Option<String>,
    #[structopt(
        name = "infile",
        short = "f",
        long,
        conflicts_with("input"),
        required_unless("input"),
        help("File to read for translation. Relative paths are accepted.")
    )]
    infile: Option<String>,
}

fn main() {
    let opt = Opt::from_args();
    let translate = match (opt.input, opt.infile) {
        (Some(instring), None) => vec![instring],
        (None, Some(infile)) => match read_file(infile) {
            Err(e) => {
                println!("{:?}", e);
                println!("File read error. Check your input.");
                exit(1)
            }
            Ok(vec) => vec,
        },
        _ => unreachable!(),
    };
    println!("Received: {:?}", translate);
    let mut translation: Vec<String> = Vec::new();
    for t in translate.iter().filter(|s| !s.is_empty()) {
        translation.push(phrase_to_morse(t.to_string()));
    }
    let translation: String = translation.join("\n");
    if translation.contains('?') {
        println!("=======================");
        println!("Input contained errors.");
        println!("=======================");
    }
    println!("Translated: {:?}", translation);
}

fn read_file(infile: String) -> io::Result<Vec<String>> {
    let mut f = File::open(infile)?;
    let mut out = String::new();
    f.read_to_string(&mut out)?;
    let out = out
        .split('\n')
        .map(|s| s.to_string())
        .collect::<Vec<String>>();
    Ok(out)
}
