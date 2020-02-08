# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RPlate::Commands::Generate::BuildView do
  describe '.call' do
    let(:entity_name) { 'MyClass' }
    let(:entity) do
      double(:entity,
             root: 'out',
             name: entity_name,
             type: 'class',
             required_methods: [])
    end

    let(:default_templates) do
      RPlate::Commands::Generate::Environment::TEMPLATES[:default]
    end

    let(:spec_templates) do
      RPlate::Commands::Generate::Environment::TEMPLATES[:spec]
    end
    let(:templates) { default_templates }
    let(:entity_constants) { ['MyClass'] }
    let(:env) { :default }
    let(:opts) { { entity_constants: entity_constants, env: env } }

    subject { described_class.call(entity, templates, opts) }

    it { is_expected.to match("class MyClass\n") }

    context 'when spec environment' do
      let(:env) { :spec }
      let(:templates) { spec_templates }

      it { is_expected.to match("RSpec.describe MyClass do\n") }
    end

    context 'when the entity constants are more than one element' do
      let(:entity_constants) { %w[MyModule MyClass] }

      it { is_expected.to match("class MyClass\n") }
      it { is_expected.to match("module MyModule\n") }
    end

    context 'when the entity constants namespace is already existing' do
      let(:entity_constants) { %w[MyNamespace MyClass] }

      before do
        FileUtils.mkdir_p('out') unless File.directory?('out')
        FileUtils.cp 'spec/fixtures/my_namespace.rb', 'out/my_namespace.rb'
      end

      after do
        File.delete('out/my_namespace.rb')
      end

      it { is_expected.to match("class MyClass\n") }

      it 'sets the right type for the already existing namespace entity' do
        expect(subject).to match("class MyNamespace\n")
      end
    end

    context 'when the entity constants are more than one element and in spec environment' do
      let(:entity_constants) { %w[MyModule MyClass] }
      let(:templates) { spec_templates }
      let(:env) { :spec }

      it { is_expected.to match("RSpec.describe MyModule::MyClass do\n") }
    end
  end
end
