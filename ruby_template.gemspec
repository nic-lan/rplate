# frozen_string_literal: true

require_relative 'lib/ruby_template/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby_template'
  spec.version       = RubyTemplate::VERSION
  spec.authors       = ['nic-lan']

  spec.summary       = 'Ruby Template Generator'
  spec.description   = 'This gem is just a template generator for ruby classes.'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'activesupport'
  spec.add_development_dependency 'hanami-validations'
  spec.add_development_dependency 'thor'
  spec.add_development_dependency 'tilt'
  spec.add_development_dependency 'zeitwerk'
end