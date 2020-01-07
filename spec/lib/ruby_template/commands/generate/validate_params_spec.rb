# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RubyTemplate::Commands::Generate::ValidateParams do
  describe '.call' do
    subject { described_class.call(class_name, options) }

    let(:class_name) { 'Whatever' }
    let(:type_value) { 'class' }
    let(:methods_value) { [] }
    let(:options) { { 'type' => type_value, 'required_methods' => methods_value } }

    it { is_expected.to be_success }

    context 'when type is module' do
      let(:type_value) { 'module' }

      it { is_expected.to be_success }
    end

    context 'when name is not present' do
      let(:class_name) {}

      it 'is not success' do
        expect(subject).not_to be_success
        expect(subject.messages).to include(name: ['must be a string'])
      end
    end

    context 'when name is blank' do
      let(:class_name) { '' }

      it 'is not success' do
        expect(subject).not_to be_success
        expect(subject.messages).to include(name: ['is in invalid format'])
      end
    end

    context 'when type is invalid' do
      let(:type_value) { 'whatever' }

      it 'is not success' do
        expect(subject).not_to be_success
        expect(subject.messages).to include(type: ['must be one of: class, module'])
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
  end
end
