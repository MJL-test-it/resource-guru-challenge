# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "array_level/version"

Gem::Specification.new do |spec|
  spec.name = 'array_level'
  spec.version = ArrayLevel::VERSION
  spec.authors = ['Mark Jordanovic-Lewis (_jail)']
  spec.email = %w[mark.4ndrew.lewis@gmail.com]
  spec.license = 'MIT'
  spec.summary = 'Monkey patch of Array class to include new (Ruby runtime level) implementation of `flatten`'
  spec.description = 'Resource Guru Code Challenge'
  spec.homepage = 'https://github.com/MJL-test-it/resource-guru-challenge'
  spec.files = 'lib/array_level.rb'
  spec.require_paths = %w[lib]


  spec.add_development_dependency 'bundler', '1.17.2'
  spec.add_development_dependency 'rspec-core', '3.9.1'
  spec.add_development_dependency 'rspec-expectations', '3.9.0'
  spec.add_development_dependency 'rspec-benchmark', '0.5.1'
  spec.add_development_dependency 'simplecov', '0.17.1'
end
