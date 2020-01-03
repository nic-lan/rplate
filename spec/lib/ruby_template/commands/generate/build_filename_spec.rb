require 'spec_helper'

RSpec.describe RubyTemplate::Commands::Generate::BuildFilename do
  describe '.call' do
    let(:name) { 'MyClass' }
    let(:root) { 'lib' }
    let(:entity) do
      RubyTemplate::Commands::Generate::Entity.new(
        name: name,
        methods: [],
        type: 'class',
        root: root
      )
    end

    subject { described_class.call(entity) }

    it { is_expected.to eq('lib/my_class.rb') }

    context 'when the given name is scoped under another namespace' do
      let(:name) { 'Whatever::MyClass' }

      it { is_expected.to eq('lib/whatever/my_class.rb') }
    end

    context 'when the given root differs from default' do
      let(:root) { 'app/controllers' }

      it { is_expected.to eq('app/controllers/my_class.rb') }
    end
  end
end
