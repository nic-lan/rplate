# frozen_string_literal: true

RSpec.describe RPlate::Commands::Generate::Context do
  describe '.create' do
    let(:entity_name) { 'MyClass' }
    let(:entity) { double('entity', name: entity_name) }
    let(:env) { :spec }
    let(:env_templates) do
      {
        one: :template,
        another: :template
      }
    end
    let(:entity_env) do
      instance_double('RPlate::Commands::Generate::Environment',
                      templates: env_templates,
                      env: env)
    end

    subject { described_class.create(entity, env: entity_env) }

    it 'returns templates in the environment' do
      expect(subject.templates).to eq(env_templates)
    end

    it 'opts includes the environment and the entity_constants' do
      expect(subject.opts).to eq(
        entity_constants: %w[MyClass],
        env: env
      )
    end

    context 'when the name is splittable in multiple resources by `::`' do
      let(:entity_name) { 'MyModule::MyClass' }

      it 'returns a default context with splitted entity_constants' do
        expect(subject.opts).to eq(
          entity_constants: %w[MyModule MyClass],
          env: env
        )
      end
    end

    context 'when the name is underscore`' do
      let(:entity_name) { 'my_class' }

      it 'returns a default context with splitted entity_constants' do
        expect(subject.opts).to eq(
          entity_constants: %w[MyClass],
          env: env
        )
      end
    end
  end
end
