use phf::phf_map;

static MORSE: phf::Map<&'static str, &str> = phf_map! {
    "A" => ".-",
    "B" => "-...",
    "C" => "-.-.",
    "D" => "-..",
    "E" => ".",
    "F" => "..-.",
    "G" => "--.",
    "H" => "....",
    "I" => "..",
    "J" => ".---",
    "K" => "-.-",
    "L" => ".-..",
    "M" => "--",
    "N" => "-.",
    "O" => "---",
    "P" => ".--.",
    "Q" => "--.-",
    "R" => ".-.",
    "S" => "...",
    "T" => "-",
    "U" => "..-",
    "V" => "...-",
    "W" => ".--",
    "X" => "-..-",
    "Y" => "-.--",
    "Z" => "--..",
    "0" => "-----",
    "1" => ".----",
    "2" => "..---",
    "3" => "...--",
    "4" => "....-",
    "5" => ".....",
    "6" => "-....",
    "7" => "--...",
    "8" => "---..",
    "9" => "----.",
    "." => ".-.-.-",
    "," => "--..--"
};

fn char_to_morse(c: &str) -> String {
    if MORSE.contains_key(c) {
        MORSE[c].to_string()
    } else {
        "?".to_string()
    }
}

fn morse_word(word: String) -> String {
    word.chars()
        .map(|c| char_to_morse(&c.to_uppercase().to_string()))
        .collect::<Vec<String>>()
        .join("/")
        .to_string()
}

pub fn phrase_to_morse(phrase: String) -> String {
    phrase
        .split_whitespace()
        .map(|word| morse_word(word.to_string()))
        .collect::<Vec<String>>()
        .join("|")
}

pub fn obfuscate_morse(morse: &String) -> String {
    let mut morse = morse.clone();
    use regex::Regex;
    Regex::new(r"(?<!\.)(\.)(?!\.)")
        .unwrap()
        .replace_all(&morse, "1");
    Regex::new(r"(?<!\.)(\.\.)(?!\.)")
        .unwrap()
        .replace_all(&morse, "2");
    Regex::new(r"(?<!\.)(\.\.\.)(?!\.)")
        .unwrap()
        .replace_all(&morse, "3");
    Regex::new(r"(?<!\.)(\.\.\.\.)(?!\.)")
        .unwrap()
        .replace_all(&morse, "4");
    Regex::new(r"(?<!\.)(\.\.\.\.\.)(?!\.)")
        .unwrap()
        .replace_all(&morse, "5");
    Regex::new(r"(?<!-)(-)(?!.)")
        .unwrap()
        .replace_all(&morse, "A");
    Regex::new(r"(?<!-)(--)(?!.)")
        .unwrap()
        .replace_all(&morse, "B");
    Regex::new(r"(?<!-)(---)(?!-)")
        .unwrap()
        .replace_all(&morse, "C");
    Regex::new(r"(?<!-)(----)(?!-)")
        .unwrap()
        .replace_all(&morse, "D");
    Regex::new(r"(?<!-)(-----)(?!-)")
        .unwrap()
        .replace_all(&morse, "E");
    morse.to_string()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn char_to_morse_test() {
        assert_eq!(char_to_morse("A"), ".-".to_owned());
    }

    #[test]
    fn morse_word_test() {
        assert_eq!(
            morse_word("abcdefghijklmnopqrstuvwxyz0123456789.,".to_owned()),
            A_TO_DOT
        );
        assert_eq!(
            morse_word("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,".to_owned()),
            A_TO_DOT
        );
    }

    #[test]
    fn handle_unknown_character_test() {
        assert_eq!(morse_word("$!@".to_owned()), "?/?/?");
    }

    #[test]
    fn phrase_to_morse_test() {
        assert_eq!(phrase_to_morse("hello, world.".to_owned()), HELLO_WORLD);
    }

    #[test]
    fn obfuscate_morse_test() {
        let hello: String = HELLO_WORLD.to_string();
        let a_to_dot: String = A_TO_DOT.to_string();
        assert_eq!(obfuscate_morse(&hello), OBS_HELLO_WORLD);
        assert_eq!(obfuscate_morse(&a_to_dot), OBS_A_TO_DOT);
    }

    /*
        Test Expectation Values
    */

    static HELLO_WORLD: &str = "...././.-../.-../---/--..--|.--/---/.-./.-../-../.-.-.-";
    static A_TO_DOT: &str = ".-/-.../-.-./-.././..-./--./..../../.---/-.-/.-../--/-./---/.--./--.-/.-./.../-/..-/...-/.--/-..-/-.--/--../-----/.----/..---/...--/....-/...../-..../--.../---../----./.-.-.-/--..--";
    static OBS_A_TO_DOT: &str = "1a/a3/a1a1/a2/1/2a1/b1/4/2/1c/a1a/1a2/b/a1/c/1b1/b1a/1a1/3/a/2a/3a/1b/a2a/a1b/b2/e/1d/2c/3b/4a/5/a4/b3/c2/d1/1a1a1a/b2b";
    static OBS_HELLO_WORLD: &str = "4/1/1a2/1a2/c/b2b|1b/c/1a1/1a2/a2/1a1a1a";
}
