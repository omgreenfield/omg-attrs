require 'rspec'
require 'ext/hash'

RSpec.describe Ext::Hash, type: :extension do
  describe '#method_missing' do
    it 'can handle simple hashes and keys' do
      expect({ a: 1 }.a).to eq(1)
    end

    it 'can handle nested hashes' do
      expect({ a: { b: 1 } }.a.b).to eq(1)
    end
  end
end
