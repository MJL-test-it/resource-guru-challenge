require 'spec_helper'

describe Array do
  context '#level' do
    it 'responds to `level` as an instance method' do
      expect([]).to respond_to(:level)
    end
    it 'removes a single nest' do
      expect([[]].level).to eq []
      expect([1, [2, 3], 4].level).to eq [1, 2, 3, 4]
    end
    it 'retains the original set of elements from deep nesting' do
      expect([[[[]]]].level).to eq []
      expect([1, [2, [3, 4, 5, [6, 7], 8], 9], 10].level).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
      expect([1, [2, [3, 4]], [5, [6, 7], [8], 9], 10].level).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    end
    it 'does not mutate the original array' do
      ary = [[[[]]]]
      obj_id = ary.object_id
      ary = ary.level
      expect(ary).to eq []
      expect(ary.object_id).not_to eq obj_id
    end
  end
  context '#level!' do
    it 'responds to `level!` as an instance method' do
      expect([]).to respond_to(:level!)
    end
    it 'returns nil (consistent with other mutator methods)' do
      expect([].level!).to be_nil
    end
    it 'mutates the original array into a flat array' do
      ary = [[[[]]]]
      obj_id = ary.object_id
      expect(ary.level!).to be_nil
      expect(ary).to eq []
      expect(ary.object_id).to eq obj_id
    end
    it 'retains the original set of elements from deep nesting' do
      ary = [1, [2, [3, 4, 5, [6, 7], 8], 9], 10]
      ary.level!
      expect(ary).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
      ary = [1, [2, [3, 4]], [5, [6, 7], [8], 9], 10]
      ary.level!
      expect(ary).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    end
  end
  context '#level vs #flatten' do
    it 'level is slower than flatten' do
      ary = [1, [2, [3, 4]], [5, [6, 7], [8], 9], 10]
      expect { ary.level }.to perform_slower_than { ary.flatten }
    end
  end
  context '#level! vs #flatten!' do
    it 'level! is slower than flatten!' do
      ary = [1, [2, [3, 4]], [5, [6, 7], [8], 9], 10]
      arry = [1, [2, [3, 4]], [5, [6, 7], [8], 9], 10]
      expect { ary.level! }.to perform_slower_than { ary.flatten! }
    end
  end
end
