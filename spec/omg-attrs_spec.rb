require 'spec_helper'
require 'rspec'

RSpec.describe Attrs do
  let(:dad_hash) do
    {
      age: 35,
      hair_color: 'brown',
      wife: { age: 35, hair_color: 'brown' },
      children:,
    }
  end
  let(:children) do
    [
      { hair_color: 'blonde', age: 7 },
      { hair_color: 'brown', age: 3 },
    ]
  end

  describe '#attrs' do
    it 'returns key/value pairs for simple attributes' do
      result = dad_hash.attrs(:age, :hair_color)
      expect(result).to eq(
        age: 35,
        hair_color: 'brown',
      )
    end

    it 'recurses through hash attributes' do
      result = dad_hash.attrs(:age, wife: %i[hair_color age])
      expect(result).to eq(
        age: 35,
        wife: {
          hair_color: 'brown',
          age: 35,
        },
      )
    end

    it 'retrieves attributes on lists' do
      result = dad_hash.attrs(children: :count)
      expect(result).to eq(
        children: { count: 2 },
      )
    end

    it 'maps arrays to an `item` attribute' do
      result = children.attrs(:age, :hair_color)
      expect(result).to eq(
        [
          {
            age: 7,
            hair_color: 'blonde',
          },
          {
            age: 3,
            hair_color: 'brown',
          },
        ],
      )
    end

    it 'can handle simple, list, and nested attributes, putting nested attributes into `items`' do
      result = dad_hash.attrs(
        :age,
        :hair_color,
        wife: %i[hair_color age],
        children: %i[count age hair_color],
      )
      expect(result).to eq(
        age: 35,
        hair_color: 'brown',
        wife: {
          age: 35,
          hair_color: 'brown',
        },
        children: {
          count: 2,
          items: [
            {
              age: 7,
              hair_color: 'blonde',
            },
            {
              age: 3,
              hair_color: 'brown',
            },
          ],
        },
      )
    end

    it 'can retrieve attributes defined by private methods' do
      klass = Class.new do
        def attrs_value
          attrs(:secret)
        end

        private def secret
          'shh'
        end
      end

      instance = klass.new

      expect(instance.attrs_value).to eq(secret: 'shh')
    end
  end

  describe '.version' do
    it 'returns the current version' do
      config = YAML.load_file(File.join(__dir__, '..', 'config.yml'))
      expect(Attrs.version).to eq(config[:version])
    end
  end
end
