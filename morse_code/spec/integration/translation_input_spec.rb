require 'spec_helper'

describe 'A yaml translator is specified to be used' do
  subject { `./morse_code --infile #{infile} --outfile #{outfile} --translator #{translation_file}` }
  let(:infile) { 'spec/support/all_symbols.txt' }
  let(:outfile) { 'translations/obfuscated_symbols.morse.txt' }
  let(:translation_file) { 'morse/translators/obfuscate.yml' }
  let(:expected_output) do

  end

end