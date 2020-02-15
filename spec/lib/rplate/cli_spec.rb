# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RPlate::CLI do
  describe '.start' do
    shared_examples 'sends to Generate class' do
      it 'succeeds' do
        expect(RPlate::Commands::Generate).to receive(:new).with(expected_entity) do
          generate_command
        end
        expect(RPlate::Logger).not_to receive(:info)
        start
      end
    end

    let(:class_name) { %w[my_class] }
    let(:start) { described_class.start(args) }
    let(:required_methods_option) { [] }
    let(:inflections) { [] }
    let(:options) do
      { 'required_methods' => required_methods_option,
        'type' => type_option,
        'inflections' => inflections,
        'root' => 'lib' }
    end
    let(:type_option) { 'class' }
    let(:addional_flags) { [] }
    let(:args) { ['generate'] + class_name + addional_flags }

    let(:generate_command) { double(:command, call: true) }
    let(:expected_entity) do
      options.merge(entity_names: class_name).deep_symbolize_keys
    end

    before do
      allow(RPlate::Logger).to receive(:info)
    end

    it_behaves_like 'sends to Generate class'

    context 'when more than one name' do
      let(:class_name) { %w[my_module my_class] }

      it_behaves_like 'sends to Generate class'
    end

    context 'when option t is given' do
      let(:type_option) { 'module' }
      let(:addional_flags) { ['-t', type_option] }

      it_behaves_like 'sends to Generate class'
    end

    context 'when option m is given' do
      let(:required_methods_option) { ['self.perform'] }
      let(:addional_flags) { ['-m', required_methods_option] }

      it_behaves_like 'sends to Generate class'
    end

    context 'when option i is given' do
      let(:inflections) { ['rplate:RPLATE', 'api:API'] }
      let(:addional_flags) { ['-i', inflections] }

      it_behaves_like 'sends to Generate class'
    end

    context 'when an invalid name is given' do
      let(:class_name) { %w[MyClass] }

      it 'succeeds' do
        expect(RPlate::Logger).to receive(:info).with(
          entity_names: { 0 => ['is in invalid format'] }
        )
        start
      end
    end

    context 'when an invalid signature is given' do
      let(:args) { ['generate', '-1'] }

      it 'logs out and exits' do
        expect(RPlate::Logger).to receive(:info).with(
          entity_names: { 0 => ['is in invalid format'] }
        )
        start
      end
    end
  end
end
