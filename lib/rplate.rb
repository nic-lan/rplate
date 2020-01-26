# frozen_string_literal: true

%w[
  thor
  active_support/core_ext/hash
  hanami-validations
  zeitwerk
  ostruct
  tilt/erb
  fileutils
  rubocop
].each { |lib| require lib }

loader = Zeitwerk::Loader.for_gem

loader.inflector.inflect(
  'cli' => 'CLI',
  'rplate' => 'RPlate'
)

loader.setup

# This needs to stay. Somehow otherwise the RPlate constant is not lodead when called
module RPlate
end
