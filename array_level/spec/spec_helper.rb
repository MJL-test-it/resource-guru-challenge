# frozen_string_literal: true
require 'bundler/setup'
require 'rspec-benchmark'
require 'array_level'
require 'simplecov'

Bundler.setup
SimpleCov.start do
  formatter SimpleCov::Formatter::HTMLFormatter
  add_filter '/spec/'
  add_filter '/version/'
end


RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers
end