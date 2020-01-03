# frozen_string_literal: true

%w[
  thor
  active_support/core_ext/hash
  hanami-validations
  zeitwerk
  ostruct
  tilt/erb
  fileutils
].each { |lib| require lib }

loader = Zeitwerk::Loader.for_gem

loader.inflector.inflect(
  'cli' => 'CLI'
)

loader.setup
