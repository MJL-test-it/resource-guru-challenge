require 'spec_helper'

describe 'morse_code stdin to stdout spec' do
  subject { `./spec/integration/morse_code --input "#{input_string}"` }

  context 'good input' do
    context 'all known tokens' do
      let(:expected) do
        %(Received: ["#{input_string}"]
Translated: ".-/-.../-.-./-.././..-./--./...././.---/-.-/.-../--/-./---/.--./--.-/.-./.../-/..-/...-/.--/-..-/-.--/--../-----/.----/..---/...--/....-/...../-..../--.../---../----./.-.-.-/--..--"
)
      end
      context 'lowercase' do
        let(:input_string) { 'abcdefghijklmnopqrstuvwxyz0123456789.,' }
        it 'parses the known symbols correctly and generates output' do
          expect(subject).to eq expected
        end
      end
      context 'uppercase' do
        context 'all known tokens in caps' do
          let(:input_string) { 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,' }
          it 'parses the known symbols correctly and generates output' do
            expect(subject).to eq expected
          end
        end
      end
      context 'hello, world.' do
        let(:input_string) { 'hello, world.' }
        let(:expected) do
          %(Received: ["#{input_string}"]
Translated: "...././.-../.-../---/--..--|.--/---/.-./.-../-../.-.-.-"
)
        end
        it 'parses `hello, world.` correctly and generates output' do
          expect(subject).to eq expected
        end
      end
    end

    context 'bad input' do
      let(:input_string) { '\$!@' }
      let(:expected) do
        %(Received: ["$!@"]
=======================
Input contained errors.
=======================
Translated: "?/?/?"
)
      end
      it 'parses the input, generates an output string and reports that the input was bad' do
        expect(subject).to eq expected
      end
    end
  end
end