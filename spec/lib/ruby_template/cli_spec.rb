# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RubyTemplate::CLI do
  describe '.start' do
    shared_examples 'sends to Generate class' do
      it 'with the given option' do
        expect(RubyTemplate::Commands::Generate).to receive(:call).with(class_name, options)
        start
      end
    end

    let(:class_name) { 'MyClass' }
    let(:start) { described_class.start(args) }
    let(:methods_option) { [] }
    let(:options) { { 'methods' => methods_option, 'type' => type_option, 'root' => 'lib' } }
    let(:type_option) { 'class' }
    let(:args) { ['generate', class_name] }

    it_behaves_like 'sends to Generate class'

    context 'when option t is given' do
      let(:type_option) { 'module' }
      let(:args) { ['generate', class_name, '-t', type_option] }

      it_behaves_like 'sends to Generate class'
    end

    context 'when option m is given' do
      let(:methods_option) { ['self.perform'] }
      let(:args) { ['generate', class_name, '-m', methods_option] }

      it_behaves_like 'sends to Generate class'
    end
  end
end
