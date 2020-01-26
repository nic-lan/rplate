# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)
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
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = ['rplate']
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'hanami-validations'
  spec.add_dependency 'rubocop'
  spec.add_dependency 'thor'
  spec.add_dependency 'tilt'
  spec.add_dependency 'zeitwerk'
end
