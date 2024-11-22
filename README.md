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
gem build attrs.gemspec

# Install gem
gem i -l /path/to/this/folder/omg-attrs-<version>.gem
```

## Usage

```ruby
require 'omg-attrs'

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

dad_hash.match?(age: 35 ) # => true

dad_hash.children.find_by(age: 7) # => { age: 7, hair_color: 'blonde' }
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
