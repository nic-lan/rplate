# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RPlate::CLI do
  describe '.start' do
    shared_examples 'sends to Generate class' do
      it 'does not raise' do
        allow(RPlate::Commands::Generate).to receive(:new) { generate_command }
        expect { start }.not_to raise_error
      end
    end

    let(:class_name) { 'MyClass' }
    let(:start) { described_class.start(args) }
    let(:required_methods_option) { [] }
    let(:options) do
      { 'required_methods' => required_methods_option, 'type' => type_option, 'root' => 'lib' }
    end
    let(:type_option) { 'class' }
    let(:args) { ['generate', class_name] }
    let(:generate_command) { double(:command, call: true) }

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

    context 'when an underscore name is given' do
      let(:class_name) { 'my_class' }

      it_behaves_like 'sends to Generate class'
    end
  end
end
