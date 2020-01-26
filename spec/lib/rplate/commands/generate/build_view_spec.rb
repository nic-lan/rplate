# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RPlate::Commands::Generate::BuildView do
  describe '.call' do
    let(:entity_name) { 'MyClass' }
    let(:entity) do
      RPlate::Commands::Generate::Entity.new(
        root: 'out',
        name: entity_name,
        type: 'class',
        required_methods: []
      )
    end

    let(:templates) do
      { layout: 'lib/templates/entity/layout.erb',
        module: 'lib/templates/entity/module.erb',
        resource: 'lib/templates/entity/resource.erb',
        method: 'lib/templates/entity/method.erb' }
    end
    let(:opts) { { entity_resources: ['MyClass'], env: :default } }

    let(:expected_view) { fixture('my_class.rb') }

    subject { described_class.call(entity, templates, opts) }

    it { is_expected.to match(entity_name) }

    context 'when spec environment' do
      let(:templates) do
        { layout: 'lib/templates/entity_spec/layout.erb',
          resource: 'lib/templates/entity_spec/resource.erb',
          method: 'lib/templates/entity_spec/method.erb' }
      end
      let(:opts) { { env: :spec } }

      it { is_expected.to match(entity_name) }
    end
  end
end
