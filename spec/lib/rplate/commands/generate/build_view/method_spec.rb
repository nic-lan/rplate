# frozen_string_literal: true

RSpec.describe RPlate::Commands::Generate::BuildView::Method do
  describe '.build' do
    let(:method_name) { 'call' }
    let(:env) { :default }

    subject(:method) { described_class.build(method_name, env) }

    specify do
      expect(method.method_name).to eq(method_name)
    end

    context 'when is `initialize`' do
      let(:method_name) { 'initialize' }

      specify do
        expect(method).to be_present
      end
    end

    context 'when test environment' do
      let(:env) { :spec }

      specify do
        expect(method.method_name).to eq('#call')
        expect(method.method_subject_name).to eq(method_name)
        expect(method.method_in_subject_block).to eq('new.call')
      end

      context 'when it is a class method' do
        let(:method_name) { 'self.call' }

        specify do
          expect(method.method_name).to eq('.call')
          expect(method.method_subject_name).to eq('call')
          expect(method.method_in_subject_block).to eq('call')
        end
      end

      context 'when is `initialize`' do
        let(:method_name) { 'initialize' }

        specify do
          expect(method).to be_nil
        end
      end
    end
  end
end
