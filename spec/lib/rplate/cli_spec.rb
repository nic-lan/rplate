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
    let(:args) { ['generate', class_name] }
    let(:generate_command) { double(:command, call: true) }
    let(:expected_entity) do
      options.merge(name: class_name).deep_symbolize_keys
    end

    before do
      allow(RPlate::Logger).to receive(:info)
    end

    it_behaves_like 'sends to Generate class'

    context 'when option t is given' do
      let(:type_option) { 'module' }
      let(:args) { ['generate', class_name, '-t', type_option] }

      it_behaves_like 'sends to Generate class'
    end

    context 'when option m is given' do
      let(:required_methods_option) { ['self.perform'] }
      let(:args) { ['generate', class_name, '-m', required_methods_option] }

      it_behaves_like 'sends to Generate class'
    end

    context 'when option i is given' do
      let(:inflections) { ['rplate:RPLATE', 'api:API'] }
      let(:args) { ['generate', class_name, '-i', inflections] }

      it_behaves_like 'sends to Generate class'
    end

    context 'when an invalid name is given' do
      let(:class_name) { %w[MyClass] }

      it 'succeeds' do
        expect(RPlate::Logger).to receive(:info).with(
          name: { 0 => ['is in invalid format'] }
        )
        start
      end
    end

    context 'when an invalid option is given' do
      let(:args) { ['generate', '-1'] }

      it 'logs out and exits' do
        expect(RPlate::Logger).to receive(:info).with(
          name: ['must be an array']
        )
        start
      end
    end
  end
end
