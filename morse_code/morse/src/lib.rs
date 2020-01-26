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

    /*
        Test Expectation Values
    */

    static HELLO_WORLD: &str = "...././.-../.-../---/--..--|.--/---/.-./.-../-../.-.-.-";
    static A_TO_DOT: &str = ".-/-.../-.-./-.././..-./--./..../../.---/-.-/.-../--/-./---/.--./--.-/.-./.../-/..-/...-/.--/-..-/-.--/--../-----/.----/..---/...--/....-/...../-..../--.../---../----./.-.-.-/--..--";
}
