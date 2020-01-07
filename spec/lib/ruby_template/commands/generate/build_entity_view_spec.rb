# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RubyTemplate::Commands::Generate::BuildEntityView do
  describe '.call' do
    let(:name) { 'MyClass' }
    let(:type) { 'class' }
    let(:root) { 'lib' }
    let(:required_methods) { [] }
    let(:entity) do
      RubyTemplate::Commands::Generate::Entity.new(
        name: name,
        required_methods: required_methods,
        type: type,
        root: root
      )
    end

    let(:fixture_filename) { 'my_class.rb' }
    let(:expected_view) { without_empty_lines fixture(fixture_filename).read }

    subject { without_empty_lines described_class.call(entity) }

    it { is_expected.to match(expected_view) }

    context 'when type is module' do
      let(:type) { 'module' }
      let(:name) { 'MyModule' }
      let(:fixture_filename) { 'my_module.rb' }

      it { is_expected.to match(expected_view) }
    end

    context 'when name is scoped within one namespace' do
      let(:name) { 'MyModule::MyClass' }

      let(:fixture_filename) { 'my_module/my_class.rb' }

      it { is_expected.to match(expected_view) }
    end

    context 'when methods are present' do
      let(:name) { 'MyClassWithMethods' }
      let(:fixture_filename) { 'my_class_with_methods.rb' }
      let(:required_methods) { ['initialize', 'self.perform'] }

      it { is_expected.to match(expected_view) }
    end
  end
end
