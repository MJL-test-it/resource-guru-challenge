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

Go into the morse_code directory. To run the tests for the morse code library
 go into morse and run `cargo test`.
 
#### todo 
- Tests for stdin->stdout
- Test for file write
- Test each CLI flag
- Translation file reader tests