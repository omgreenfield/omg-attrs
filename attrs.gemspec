# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'omg-attrs'
  spec.version = '0.1.2'
  spec.authors = ['Matthew Greenfield']
  spec.email = ['mattgreenfield1@gmail.com']

  spec.summary = 'Allows all objects to call `.attrs` which acts as a recursive `.slice` method'
  spec.description = 'Makes it easy to slice and dice objects and collections of objects'

  spec.homepage = 'https://github.com/omgreenfield/attrs'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*.rb']
  spec.require_paths = ['lib']
end
