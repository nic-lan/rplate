# frozen_string_literal: true

lp = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lp) unless $LOAD_PATH.include?(lp)

require 'rplate/version'

Gem::Specification.new do |spec|
  spec.name          = 'rplate'
  spec.version       = RPlate::VERSION
  spec.authors       = ['Nicolas Languille']
  spec.email         = ['me@niclan.io']

  spec.summary       = 'A ruby template generator'
  spec.description   = 'This gem is just a template generator for ruby classes.'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir[
    'README.md',
    'LICENSE.txt',
    'exe/**/*',
    'lib/**/{*,.[a-z]*}',
    'templates/**/{*,.[a-z]*}',
    '.rubocop.yml'
  ]

  spec.bindir        = 'exe'
  spec.executables   = ['rplate']
  spec.require_paths = %w[lib templates]

  spec.add_dependency 'activesupport', '~> 6.0.2'
  spec.add_dependency 'dry-validation', '~> 1.4'
  spec.add_dependency 'rubocop', '~> 0.79'
  spec.add_dependency 'rubocop-performance'
  spec.add_dependency 'rubocop-rspec'
  spec.add_dependency 'thor', '~> 1.0'
  spec.add_dependency 'tilt', '~> 2.0'
  spec.add_dependency 'zeitwerk', '~> 2.2.2'
end
