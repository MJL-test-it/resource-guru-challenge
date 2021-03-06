# Morse Code Challenge
## Description
The challenge presented is as follows:

Write a program that will accept text either from stdin, or as a file path and will translate the alphanumeric sentence to Morse code. Then for bonus points, obfuscate the Morse code. ~Below is a list of international Morse code and the algorithm for obfuscation.~ Separate letters with pipe (|), and separate words with forward slash (/).

For obfuscation, your team decided to replace the number of consecutive dots with a number, and replace the number of consecutive dashes with the letter of the alphabet at that position. E.g. S = ... = 3, Q = --.- = b1a, F = ..-. = 2a1.

## Proposed Solution
- Write a morse code translator library for input strings
- In main read the stdin given on program run, process through morse code
 translator, output to screen.
- Add file write in main.
- Add CLI interface to read from file/stdin, write to file/stdout and help
 message.
- Add obfuscation option that will run a further pass over the output text.
    - turned into a Ruby wrapper.

## Usage
To build the project you must have rust installed. The easiest way to do this (and this is true for all common languages) is to use `asdf`. The installation guide for asdf is found here:
  
https://asdf-vm.com/#/core-manage-asdf-vm

on following the instructions there you need to install rust itself:

```
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf install rust stable
```

this will give you the latest stable version of rust.

## Testing
The library functionality is tested in `morse/src/lib.rs` To run the tests
, enter `morse` and run `cargo test`.

Integration tests are run through rspec in the project root (`morse_code
/`). A helper script has been supplied to assist in the integration spec run
. To use the script run:

```bash
ruby run_specs.rb --help
``` 
Running the integration specs will remove all the translated files in the
 directories in a clean up step. _Including any in the `translations` directory_.
 
 
## Usage
To run the Rust morse code generator run:

```bash
./build_release.sh
./morse_code --help
```

to run the obfuscated morse code generator run:
```
ruby obfuscate.rb --help
```

these commands will display the options to use to interact with the CLIs.

### Improvements
- This would be better if the program could be put on PATH and called
 wherever. Currently the reliance on the translations dir for dumping translated files when no output filepath is given would cause some mess in the users drive.
- I'm also not sure if the integration specs will complete successfully on a
 windows machine due to the carriage return. I _think_ that MRI deals with that
  but I know JRuby does not.
- From the integration specs you can see there is a little difference in the
 output. An extra newline between the file read input and output, if there is a
  new line
  at the end of the file (which most IDEs can be set to do), along with a new
   line at the end of the stdout expectations, rather than in the file
    written. This could be handled. I may yet.
- There is a way to use lookback and look ahead regex's in rust, in the `fancy-regex` crate but I decided
to avoid that route due to time constraints (the crate does not expose a replace method and only indexes position of matches via start and end byte position - I felt that was going to be too fiddly for this) and used the opportunity to write
 a wrapper around the Rust cli using Ruby instead.
 - Leveraging https://github.com/danielpclark/rutie for Ruby/Rust integration was my initial plan.

### Learnings
- I had a few goes at different CLI libraries in Rust, the standard library provides one sufficient for basin input but handling flags took too much lift. `structopt` provides a good abstraction over `clap` and was a little more readable so I stuck with that.
- The `regex` library in Rust does not handle any lookaround features. The maintainer suggests that the effort involved is too great. The functionality is availble in another crate, `fancy-regex`, without replace.
- The gems handling system calls in RSpec are now out of comission, this required a build script for the integration specs to be run in a wrapper script.
- (this is an already known but worth mentioning) Development speed in Ruby is greater than in Rust, at the cost of type safety and considerably slower execution speed, however Rust's std test library and package management are very easy to work with.
