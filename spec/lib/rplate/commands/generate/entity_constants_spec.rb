# frozen_string_literal: true

RSpec.describe RPlate::Commands::Generate::EntityConstants do
  describe '.fetch' do
    let(:entity_name) { 'MyClass' }
    let(:entity) { double(:entity, name: entity_name) }

    subject { described_class.fetch(entity) }

    it { is_expected.to eq(%w[MyClass]) }

    context 'when constants splitted by :: are given' do
      let(:entity_name) { 'MyModule::MyClass' }

      it { is_expected.to eq(%w[MyModule MyClass]) }
    end

    context 'when underscored class name is given' do
      let(:entity_name) { 'my_class' }

      it { is_expected.to eq(%w[MyClass]) }
    end

    context 'when underscored class name splittable by `/` is given' do
      let(:entity_name) { 'my_module/my_class' }

      it { is_expected.to eq(%w[MyModule MyClass]) }
    end

    context 'when underscored class name splittable by `:` is given' do
      let(:entity_name) { 'my_module:my_class' }

      it { is_expected.to eq(%w[MyModule MyClass]) }
    end
  end
end
