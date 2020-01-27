# frozen_string_literal: true

RSpec.describe RPlate::Commands::Generate::Context do
  describe '.create' do
    let(:entity_name) { 'MyClass' }
    let(:entity) { double('entity', name: entity_name) }
    let(:env) { :spec }

    let(:entity_env) do
      RPlate::Commands::Generate::EntityEnv.new(env)
    end

    subject { described_class.create(entity, env: entity_env) }

    it 'returns a spec context templates' do
      expect(subject.templates).to eq(
        layout: 'templates/entity_spec/layout.erb',
        method: 'templates/entity_spec/method.erb',
        resource: 'templates/entity_spec/resource.erb'
      )
    end

    it 'returns a spec context opts' do
      expect(subject.opts).to eq(env: :spec)
    end

    context 'when the given context is an entity' do
      let(:env) { :default }
      let(:templates) do
        {
          layout: 'templates/entity/layout.erb',
          method: 'templates/entity/method.erb',
          module: 'templates/entity/module.erb',
          resource: 'templates/entity/resource.erb'
        }
      end

      it 'returns a default context' do
        expect(subject.templates).to eq(templates)
        expect(subject.opts).to eq(
          entity_resources: %w[MyClass],
          env: env
        )
      end

      context 'when the name is splittable in multiple resources' do
        let(:entity_name) { 'MyModule::MyClass' }
        let(:templates) do
          {
            layout: 'templates/entity/layout.erb',
            method: 'templates/entity/method.erb',
            module: 'templates/entity/module.erb',
            resource: 'templates/entity/resource.erb'
          }
        end

        it 'returns a default context with splitted entity_resources' do
          expect(subject.templates).to eq(templates)
          expect(subject.opts).to eq(
            entity_resources: %w[MyModule MyClass],
            env: env
          )
        end
      end
    end
  end
end
