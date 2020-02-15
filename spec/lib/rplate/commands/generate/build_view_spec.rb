# frozen_string_literal: true

RSpec.describe RPlate::Commands::Generate::BuildView do
  describe '.call' do
    let(:entity_names) { %w[my_class] }
    let(:inflections) { [] }
    let(:entity) do
      double(:entity,
             root: 'out',
             entity_names: entity_names,
             type: 'class',
             required_methods: [],
             inflections: inflections)
    end

    let(:default_templates) do
      RPlate::Commands::Generate::Environment::TEMPLATES[:default]
    end

    let(:spec_templates) do
      RPlate::Commands::Generate::Environment::TEMPLATES[:spec]
    end
    let(:env) { :default }
    let(:context) { RPlate::Commands::Generate::Context.new(env) }

    subject { described_class.call(entity, context) }

    it { is_expected.to match("class MyClass\n") }

    context 'when spec environment' do
      let(:env) { :spec }

      it { is_expected.to match("RSpec.describe MyClass do\n") }
    end

    context 'when the entity constants are more than one element' do
      let(:entity_names) { %w[my_module my_class] }

      it { is_expected.to match("class MyClass\n") }
      it { is_expected.to match("module MyModule\n") }
    end

    context 'when the entity constants namespace is already existing' do
      let(:entity_names) { %w[my_namespace my_class] }

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
      let(:entity_names) { %w[my_module my_class] }
      let(:env) { :spec }

      it { is_expected.to match("RSpec.describe MyModule::MyClass do\n") }
    end
  end
end
