- [Installation](#installation)
  - [From RubyGems.org](#from-rubygemsorg)
    - [Globally](#globally)
    - [In `Gemfile`](#in-gemfile)
  - [Locally](#locally)
- [Usage](#usage)
  - [Indifferent access](#indifferent-access)
- [Development](#development)
  - [Installation](#installation-1)
  - [Console](#console)
  - [Test](#test)

This gem monkey patches `Object` and `Array` with methods that allow querying and slicing nested records and attributes.

- `Object` (and therefore also `Array`) gains:
  - `attrs` - Slice nested attributes/method evaluations in specified structure
  - `oattrs` - Alias for `attrs` in case of name conflict
  - `attrs_match?` - Check, with indifferent access, if evaluating two attributes/methods match or evaluate to `true`
- `Array` return item where `attrs_match?` is true
  - `where` - Return all items
  - `find_by` - Return first item

See examples under [Usage](#usage)

## Installation

### From RubyGems.org

#### Globally

```sh
gem i omg-attrs
```

#### In `Gemfile`

```ruby
gem 'omg-attrs'
```

### Locally

```sh
# Build gem
gem build omg-attrs.gemspec

# Install gem
gem i -l /path/to/this/folder/omg-attrs-<version>.gem
```

Or in a `Gemfile`

```ruby
gem 'omg-attrs', path: '/path/to/this/folder'
```

## Usage

```ruby
require 'omg-attrs'

# Given this object:

dad_hash = {
  age: 36,
  hair_color: 'brown',
  children: [
    { age: 4, hair_color: 'blonde' },
    { age: 8, hair_color: 'brown' }
  ],
  wife: { age: 37, hair_color: 'brown' }
}

# Examples

## Single attribute
dad_hash.attrs(:age) # => { age: 36 }

## Multiple attributes, attributes on collections, attributes on items
dad_hash.attrs(wife: :age, children: [:count, :age])
# => {
#   wife: {
#     age: 36
#   },
#   children: {
#     count: 2,
#     items: [
#       { age: 8 },
#       { age: 4 },
#     ],
#   },
# }

## Additional helper methods on Objects
dad_hash.attrs_match?(age: 36, hair_color: 'brown') # => true
dad_hash.children.find_by(age: 4) # => { age: 4, hair_color: 'brown' }
dad_hash.children.where(hair_color: 'brown') # => [{ age: 4, hair_color: 'brown' }]

## COMING SOON: Transformations via procs
dad_hash.attrs(children: [-> { deep_stringify_keys }, -> { sort_by(&:age).reverse }, :age])
[{ 'age' => 8 }, { 'age' => 4 }]
```

### Indifferent access



## Development

### Installation

```sh
bin/install
```

### Console

```sh
bin/console
```

### Test

```sh
rspec
# or
bundle exec rspec
# or
guard
```
