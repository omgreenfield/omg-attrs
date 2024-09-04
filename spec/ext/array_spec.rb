require 'rspec'
require 'ext/array'
require 'ext/object'

RSpec.describe Ext::Array, type: :extension do
  before { Array.include(Ext::Object) }

  describe '#where' do
    it 'can handle simple hashes and keys' do
      expect([{ a: 1 }, { a: 2 }].where(a: 1)).to eq([{ a: 1 }])
      expect([{ a: 1 }, { a: 2 }].where(a: 2)).to eq([{ a: 2 }])
    end

    it 'can handle simple hashes and method calls' do
      expect([{ a: 1 }, { a: 2 }].where(a: :odd?)).to eq([{ a: 1 }])
      expect([{ a: 1 }, { a: 2 }].where(a: :even?)).to eq([{ a: 2 }])
    end

    it 'can handle nested hashes' do
      expect([{ a: { b: 1 } }, { a: { b: 2 } }].where(a: { b: 1 })).to contain_exactly({ a: { b: 1 } })
    end
  end

  describe '#find_by' do
    it 'can find by simple hashes and keys' do
      expect([{ a: 1 }, { b: 2 }].find_by(a: 1)).to eq({ a: 1 })
      expect([{ a: 1 }, { b: 2 }].find_by(b: 2)).to eq({ b: 2 })
    end

    it 'can find by simple hashes and method calls' do
      expect([{ a: 1 }, { b: 2 }].find_by(a: :odd?)).to eq({ a: 1 })
      expect([{ a: 1 }, { b: 2 }].find_by(b: :even?)).to eq({ b: 2 })
    end

    it 'can find by nested hashes' do
      expect([{ a: { b: 1 } }, { a: { b: 2 } }].find_by(a: { b: 1 })).to eq({ a: { b: 1 } })
      expect([{ a: { b: 1 } }, { a: { b: 2 } }].find_by(a: { b: 2 })).to eq({ a: { b: 2 } })
    end
  end
end
