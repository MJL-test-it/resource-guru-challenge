# Morse Code Challenge
## Description
The challenge presented is as follows:

Write a program that will accept text either from stdin, or as a file path and will translate the alphanumeric sentence to Morse code. Then for bonus points, obfuscate the Morse code. Below is a list of international Morse code and the algorithm for obfuscation. Separate letters with pipe (|), and separate words with forward slash (/).

For obfuscation, your team decided to replace the number of consecutive dots with a number, and replace the number of consecutive dashes with the letter of the alphabet at that position. E.g. S = ... = 3, Q = --.- = b1a, F = ..-. = 2a1.

## Proposed Solution
- Write a morse code translator library for input strings (DONE)
- In main read the stdin given on program run, process through morse code translator, output to screen
- Add file write in main
- Add CLI interface to read from file/stdin, write to file/stdout and help message
- Add option to read in from translation file for obfuscation - edit
 translator to take a HashMap read in from the yaml

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
 directories in a clean up step. 
 
#### todo
- Translation file reader tests

### TODO
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