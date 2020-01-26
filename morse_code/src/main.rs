use ::std::io;
use morse::phrase_to_morse;
use std::fs::File;
use std::io::{Read, Write};
use std::path::Path;
use std::process::exit;
use std::time::SystemTime;
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
    #[structopt(
        name = "outfile",
        short = "o",
        long,
        default_value = "__NOFILE__",
        help("Instruction to write to an output file as well as std out. 'default' writes to /translations.")
    )]
    outfile: String,
    #[structopt(
        name = "translator",
        short = "t",
        long,
        default_value = "__NOFILE__",
        help("Instruction to read a yaml file to provide the translation.")
    )]
    translation_file: String,
}

fn main() -> std::io::Result<()> {
    let opt = Opt::from_args();
    let translate: Vec<String> = read_strings_to_translate(opt.input.clone(), opt.infile.clone());
    let translation: String = translate_input(&translate);

    let mut out_buf: Vec<&str> = Vec::new();
    let input: String;
    {
        // Handle bad input
        if translation.contains('?') {
            out_buf.push("=======================");
            out_buf.push("Input contained errors.");
            out_buf.push("=======================");
            out_buf.push("Received:");
            input = translate.join('\n'.to_string().as_str());
            out_buf.push(input.as_str());
            out_buf.push("Translated:");
        }
    }

    let outpath: Option<String> = generate_output_filepath(opt.outfile.clone(), opt.infile.clone());
    match outpath {
        None => {
            out_buf.push(&translation);
            println!("{}", out_buf.join('\n'.to_string().as_str()));
            exit(0)
        }
        Some(outpath) => {
            let outpath = outpath.as_str().replace("\"", "");
            println!("Writing to: {}", outpath);
            out_buf.push(&translation);
            let mut outfile = File::create(outpath)?;
            outfile.write_all(out_buf.join('\n'.to_string().as_str()).as_ref())?;
        }
    }
    Ok(())
}

fn read_strings_to_translate(input: Option<String>, infile: Option<String>) -> Vec<String> {
    match (input, infile) {
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
    }
}

fn translate_input(translate: &Vec<String>) -> String {
    let mut translation: Vec<String> = Vec::new();
    for t in translate.iter().filter(|s| !s.is_empty()) {
        translation.push(phrase_to_morse(t.to_string()));
    }
    translation.join('\n'.to_string().as_str())
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

fn generate_output_filepath(outfile: String, infile: Option<String>) -> Option<String> {
    match outfile.as_str() {
        "__NOFILE__" => {
            let outfile_called = Opt::clap().get_matches().occurrences_of("outfile") > 0;
            if outfile_called {
                println!("`--output` used but no filepath supplied.");
            }
            None
        }
        "default" => Some(choose_filepath(infile)),
        outpath => {
            let path = Path::new(&outpath);
            if let Some(dir) = path.parent() {
                if dir.exists() && dir.is_dir() {
                    Some(outpath.to_string())
                } else {
                    Some(format!("translations/{:?}.txt", path.file_stem().unwrap()))
                }
            } else {
                Some(format!("translations/{}", outpath))
            }
        }
    }
}

fn default_filename() -> String {
    let now = match SystemTime::now().duration_since(SystemTime::UNIX_EPOCH) {
        Ok(n) => n.as_secs().to_string(),
        Err(_) => "invalid_time_code".to_string(),
    };
    format!("translations/morse_{}.txt", now)
}

fn choose_filepath(infile: Option<String>) -> String {
    match infile {
        None => default_filename(),
        Some(filepath) => {
            let path = Path::new(&filepath);
            let basename = match path.file_stem() {
                Some(os_basename) => format!("{:?}.morse.txt", os_basename),
                None => return default_filename(),
            };
            match path.parent() {
                Some(path) => format!("{:?}/{}", path, basename),
                None => format!("translations/{}", basename),
            }
        }
    }
}
