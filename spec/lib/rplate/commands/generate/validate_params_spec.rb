# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RPlate::Commands::Generate::ValidateParams do
  describe '.call' do
    subject { described_class.call(class_name, options) }

    let(:class_name) { %w[whatever] }
    let(:type_value) { 'class' }
    let(:methods_value) { [] }
    let(:inflections) { [] }
    let(:options) do
      { 'type' => type_value,
        'required_methods' => methods_value,
        'inflections' => inflections }
    end

    it { is_expected.to be_success }

    context 'when type is module' do
      let(:type_value) { 'module' }

      it { is_expected.to be_success }
    end

    context 'when name is not present' do
      let(:class_name) {}

      it 'is not success' do
        expect(subject).not_to be_success
        expect(subject.errors.to_h).to include(name: ['must be an array'])
      end
    end

    context 'when name is underscored' do
      let(:class_name) { %w[my_class] }

      it 'is success' do
        expect(subject).to be_success
      end
    end

    context 'when name is downcase with spaces' do
      let(:class_name) { %w[my_module my_class] }

      it 'is success' do
        expect(subject).to be_success
      end
    end

    context 'when name is camelized with spaces' do
      let(:class_name) { %w[MyModule MyClass] }

      it 'is not success' do
        expect(subject).not_to be_success
        expect(subject.errors.to_h).to include(
          name: {
            0 => ['is in invalid format'], 1 => ['is in invalid format']
          }
        )
      end
    end

    context 'when name is downcase and splitted by `/`' do
      let(:class_name) { %w[my_module/my_class] }

      it 'is not success' do
        expect(subject).not_to be_success
        expect(subject.errors.to_h).to include(name: { 0 => ['is in invalid format'] })
      end
    end

    context 'when name is downcase with namespace with : separation' do
      let(:class_name) { %w[my_module:my_class] }

      it 'is not success' do
        expect(subject).not_to be_success
        expect(subject.errors.to_h).to include(name: { 0 => ['is in invalid format'] })
      end
    end

    context 'when name is blank' do
      let(:class_name) { '' }

      it 'is not success' do
        expect(subject).not_to be_success
        expect(subject.errors.to_h).to include(name: ['size cannot be less than 1'])
      end
    end

    context 'when name is start with number and underscore' do
      let(:class_name) { %w[2class] }

      it 'is not success' do
        expect(subject).not_to be_success
        expect(subject.errors.to_h).to include(name: { 0 => ['is in invalid format'] })
      end
    end

    context 'when name is start with number' do
      let(:class_name) { %w[2Class] }

      it 'is not success' do
        expect(subject).not_to be_success
        expect(subject.errors.to_h).to include(name: { 0 => ['is in invalid format'] })
      end
    end

    context 'when type is invalid' do
      let(:type_value) { 'whatever' }

      it 'is not success' do
        expect(subject).not_to be_success
        expect(subject.errors.to_h).to include(type: ['must be one of: class, module'])
      end
    end

    context 'when methods is present' do
      let(:methods_value) { ['perform'] }

      it { is_expected.to be_success }
    end

    context 'when methods has a number' do
      let(:methods_value) { %w[perform 5] }

      it { is_expected.not_to be_success }
    end

    context 'when methods has a class method' do
      let(:methods_value) { ['perform', 'self.class_method'] }

      it { is_expected.to be_success }
    end

    context 'when inflections is one valid element' do
      let(:inflections) { ['rplate:RPlate'] }

      it { is_expected.to be_success }
    end

    context 'when inflections is one valid element' do
      let(:inflections) { ['rplate-RPlate'] }

      it 'is not success' do
        expect(subject).not_to be_success
        expect(subject.errors.to_h).to include(
          inflections: {
            0 => ['is in invalid format']
          }
        )
      end
    end

    context 'when inflections is one invalid element' do
      let(:inflections) { ['RPlate:rplate'] }

      it 'is not success' do
        expect(subject).not_to be_success
        expect(subject.errors.to_h).to include(
          inflections: {
            0 => ['is in invalid format']
          }
        )
      end
    end
  end
end
