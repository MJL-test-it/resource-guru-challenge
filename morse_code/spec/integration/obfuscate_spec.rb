require 'spec_helper'

describe 'Obfuscation ruby wrapper for morse code generator' do
  context 'when given an input file' do
    let(:infile) { 'spec/support/morse_alphabet.txt' }
    let(:expected) { "1A/A3/A1A1/A2/1/2A1/B1/4/2/1C/A1A/1A2/B/A1/C/1B1/B1A/1A1/3/A/2A/3A/1B/A2A/A1B/B2/E/1D/2C/3B/4A/5/A4/B3/C2/D1/1A1A1A/B2B\n" }
    context 'and no output file' do
      subject { `ruby obfuscate.rb --infile #{infile}` }
      it 'reads the infile and outputs the result to stdout' do
        expect(subject).to eq expected
      end
    end
    context 'and an output file' do
      subject { `ruby obfuscate.rb --infile #{infile} --outfile #{outfile}` }
      let(:outfile) { 'spec/support/morse_alphabet.mc.txt' }
      let(:program_output) do
        %(Writing to: #{outfile}
Written to: #{outfile.gsub('.txt', '.obs.txt')}
)
      end
      it 'reads the output file and generates a new output file' do
        expect(subject).to eq program_output
        expect(File.exist?(outfile)).to be true
        expect(File.exist?(outfile.gsub('.txt', '.obs.txt')))
      end
    end
  end
  context 'when given an invalid input string' do
    subject { `ruby obfuscate.rb --input $£@` }
    let(:expected) do
      %(======================================================
An error occurred in the run, please check your input:
======================================================
=======================
Input contained errors.
=======================
Received:
$£@
Translated:
?/?/?
)
    end
    it 'reports that there is an error and outputs `morse_code`s output' do
      expect(subject).to eq expected
    end
  end
end
