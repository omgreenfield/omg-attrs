- [Installation](#installation)
  - [From RubyGems.org](#from-rubygemsorg)
    - [Globally](#globally)
    - [In `Gemfile`](#in-gemfile)
  - [Locally](#locally)
- [Usage](#usage)
- [Development](#development)
  - [Installation](#installation-1)
  - [Console](#console)
  - [Test](#test)

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

dad_hash = {
  age: 36,
  hair_color: 'brown',
  children: [
    { age: 4, hair_color: 'blonde' },
    { age: 8, hair_color: 'brown' }
  ],
  wife: { age: 37, hair_color: 'brown' }
}

dad_hash.attrs(:age) # => { age: 36 }

dad_hash.attrs(wife: :age, children: [:count, :age])
=> {
  wife: {
    age: 36
  },
  children: {
    count: 2,
    items: [
      { age: 8 },
      { age: 4 },
    ],
  },
}

dad_hash.attrs_match?(age: 36, hair_color: 'brown') # => true
dad_hash.children.find_by(age: 4) # => { age: 4, hair_color: 'brown' }
dad_hash.children.where(hair_color: 'brown') # => [{ age: 4, hair_color: 'brown' }]
```

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
