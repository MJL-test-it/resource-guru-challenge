require 'spec_helper'

describe 'Reading from a file' do
  subject { `./morse_code --infile #{path}` }
  let(:expected) do
    %(Received: ["abcdefghijklmnopqrstuvwxyz0123456789.,", "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,", "$!@", "hello, world", ""]
=======================
Input contained errors.
=======================
Translated: ".-/-.../-.-./-.././..-./--./...././.---/-.-/.-../--/-./---/.--./--.-/.-./.../-/..-/...-/.--/-..-/-.--/--../-----/.----/..---/...--/....-/...../-..../--.../---../----./.-.-.-/--..--\\n.-/-.../-.-./-.././..-./--./...././.---/-.-/.-../--/-./---/.--./--.-/.-./.../-/..-/...-/.--/-..-/-.--/--../-----/.----/..---/...--/....-/...../-..../--.../---../----./.-.-.-/--..--\\n?/?/?\\n...././.-../.-../---/--..--|.--/---/.-./.-../-.."
)
  end
  context 'translation printed to stdout' do
    context 'with an absolute path' do
      let(:path) { '$(pwd)/spec/support/all_symbols.txt' }
      it 'reads the file, translates the string and prints to stdout' do
        expect(subject).to eq expected
      end
    end
    context 'with a relative path' do
      let(:path) { '../morse_code_spec_support/test_relative_path.txt' }
      it 'reads the file, translates the string and prints to stdout' do
        expect(subject).to eq expected
      end
    end
  end
end
