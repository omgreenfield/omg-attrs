- [Installation](#installation)
  - [From RubyGems.org](#from-rubygemsorg)
    - [Globally](#globally)
    - [In `Gemfile`](#in-gemfile)
  - [Locally](#locally)
- [Usage](#usage)
- [Running tests](#running-tests)

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
gem build attrs.gemspec

# Install gem
gem i -l /path/to/this/folder/omg-attrs-<version>.gem
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

dad_hash.attrs(:age)
=> { age: 35 }

dad_hash.attrs(wife: :age, children: [:count, :age])
=> {
  wife: {
    age: 35
  },
  children: {
    count: 2,
    items: [
      { age: 7 },
      { age: 3 },
    ],
  },
}
```

## Running tests

```sh
rspec
# or
bundle exec rspec
# or
guard
```
