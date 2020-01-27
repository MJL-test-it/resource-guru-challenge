require 'spec_helper'
require 'fileutils'

describe 'Reading from an input file and writing the translation to a file' do
  let(:expected_in_file) do
    %(=======================
Input contained errors.
=======================
Received:
abcdefghijklmnopqrstuvwxyz0123456789.,
ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,
$!@
hello, world

Translated:
.-/-.../-.-./-.././..-./--./..../../.---/-.-/.-../--/-./---/.--./--.-/.-./.../-/..-/...-/.--/-..-/-.--/--../-----/.----/..---/...--/....-/...../-..../--.../---../----./.-.-.-/--..--
.-/-.../-.-./-.././..-./--./..../../.---/-.-/.-../--/-./---/.--./--.-/.-./.../-/..-/...-/.--/-..-/-.--/--../-----/.----/..---/...--/....-/...../-..../--.../---../----./.-.-.-/--..--
?/?/?
...././.-../.-../---/--..--|.--/---/.-./.-../-..)
  end
  let(:infile) { 'spec/support/all_symbols.txt' }
  context 'when a default file is specified' do
    subject { `./morse_code --infile #{infile} --outfile default` }
    let(:expected_stdout) { "Writing to: spec/support/all_symbols.morse.txt\n" }
    let(:default_file) { 'spec/support/all_symbols.morse.txt' }
    it 'successfully reads input and writes the file to the directory of the input file' do
      expect(subject).to eq expected_stdout
      expect(File.exist?(default_file)).to be true
      expect(File.open(default_file).readlines.join).to eq expected_in_file
    end
  end
  context 'when a file is specified' do
    subject { `./morse_code --infile #{infile} --outfile #{outfile}` }
    context 'when a non-existing dir is used' do
      let(:expected_stdout) { "Writing to: translations/redirected_write.morse.txt\n" }
      let(:outfile) { 'spec/suppt/redirected_write.morse.txt'}
      let(:redirected_write_path) { 'translations/redirected_write.morse.txt' }
      it 'a file in translations/ is written using the basename of the requested file' do
        expect(subject).to eq expected_stdout
        expect(File.exist?(redirected_write_path)).to be true
        expect(File.open(redirected_write_path).readlines.join).to eq expected_in_file
      end
    end
    context 'correctly' do
      let(:outfile) { 'spec/infile_outfile_support/write.morse.txt'}
      let(:expected_stdout) { "Writing to: spec/infile_outfile_support/write.morse.txt\n" }
      it 'a file in translations/ is written using the basename of the requested file' do
        expect(subject).to eq expected_stdout
        expect(File.exist?(outfile)).to be true
        expect(File.open(outfile).readlines.join).to eq expected_in_file
      end
    end

  end
  context 'when no file is specified' do
    subject { `./morse_code --infile #{infile} --outfile` }
    it 'no file is created and the output is piped to stdout' do
      expect(subject).to eq "`--output` used but no filepath supplied.\n#{expected_in_file}\n"
    end
  end
end