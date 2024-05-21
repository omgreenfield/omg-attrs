# frozen_string_literal: true

require 'ostruct'

RSpec.describe Attrs do
  it 'allows recursive slice-like attribute fetching' do
    dad_hash = {
      age: 35,
      hair_color: 'brown',
      children: [
        { age: 7, hair_color: 'blonde' },
        { age: 3, hair_color: 'brown' }
      ],
      wife: { age: 35, hair_color: 'brown' }
    }

    expect(dad_hash.attrs(:age, wife: %i[hair_color age], children: %i[hair_color age])).to eq(
      {
        age: 35,
        wife: { hair_color: 'brown', age: 35 },
        children: [
          { hair_color: 'blonde', age: 7 },
          { hair_color: 'brown', age: 3 },
        ],
      }
    )

    dad_object = OpenStruct.new(dad_hash)
    expect(dad_object.attrs(:age, wife: %i[hair_color age], children: %i[hair_color age])).to eq(
      {
        age: 35,
        wife: { hair_color: 'brown', age: 35 },
        children: [
          { hair_color: 'blonde', age: 7 },
          { hair_color: 'brown', age: 3 },
        ],
      }
    )

    children_array = dad_object.children
    expect(children_array.attrs(:hair_color, :age)).to eq([{ hair_color: 'blonde', age: 7 }, { hair_color: 'brown', age: 3 }])

    nested_array = [[1], [2], [3]]
    expect(nested_array.attrs(:first)).to eq([1, 2, 3])
  end
end
