require 'spec_helper'

describe Array do
  context '#level' do
    it 'responds to level as an instance method' do
      expect([]).to respond_to(:level)
    end
  end
end
