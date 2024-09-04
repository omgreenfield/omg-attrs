require 'rspec'
require 'ext/object'

RSpec.describe Ext::Object, type: :extension do
  before do
    Hash.include(Ext::Object)
  end

  describe '#match?' do
    it 'returns true when a match is found' do
      expect({ a: 1, b: 2 }.match?(a: 1, b: 2)).to be(true)
    end

    it 'returns false when a match is not found' do
      expect({ a: 1, b: 2 }.match?(a: 1, b: 3)).to be(false)
    end
  end
end
