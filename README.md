# Attrs

## Installation

### From RubyGems.org

```sh
gem i omg-attrs
```

### Locally

```sh
# Build gem
gem build attrs.gemspec

# Install gem
gem i -l /path/to/this/folder/omg-attrs-0.1.0.gem
```

## Usage

```ruby
require 'attrs'

dad_hash = {
  age: 35,
  hair_color: 'brown',
  children: [
    { age: 7, hair_color: 'blonde' },
    { age: 3, hair_color: 'brown' }
  ],
  wife: { age: 35, hair_color: 'brown' }
}

dad_hash.attrs(:age) # => 35
dad_hash.attrs(wife: :age, children: :hair_color) # =>
# {
#   wife: 35,
#   children: [
#     { hair_color: 'blonde' },
#     { hair_color: 'brown'  },
#   ],
# }
```

## Running tests

```ruby
rspec

# or
bundle exec rspec
```
