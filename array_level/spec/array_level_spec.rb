require 'spec_helper'

describe Array do
  context '#level' do
    it 'responds to level as an instance method' do
      expect([]).to respond_to(:level)
    end
    it 'removes a single nest' do
      expect([[]].level).to eq []
      expect([1,[2,3],4].level).to eq [1,2,3,4]
    end
    it 'removes deeper then one nests' do
      expect([[[[]]]]).to eq []
    end
  end
end
