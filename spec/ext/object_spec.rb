require 'rspec'
require 'ext/object'

RSpec.describe Ext::Object, type: :extension do
  describe '#attrs_match?' do
    it 'can handle simple hashes and keys' do
      expect({ a: 1 }.attrs_match?(a: 1)).to be(true)
      expect({ a: 1 }.attrs_match?(a: 2)).to be(false)
    end

    it 'can handle simple hashes and method calls' do
      expect({ a: 1 }.attrs_match?(a: :odd?)).to be(true)
      expect({ a: 2 }.attrs_match?(a: :odd?)).to be(false)
    end

    it 'can handle nested hashes' do
      expect({ a: { b: 1 } }.attrs_match?(a: { b: 1 })).to be(true)
      expect({ a: { b: 1 } }.attrs_match?(a: { b: 2 })).to be(false)
    end
  end
end
