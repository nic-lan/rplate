# frozen_string_literal: true

RSpec.describe RPlate::Commands::Generate::BuildView::Namespace do
  describe '#type' do
    let(:name) { 'MyClassNamespace' }
    let(:root_dir) { 'out' }
    let(:entity_constants) { %w[MyClassNamespace MyClass] }

    subject { described_class.new(name, entity_constants, root_dir).type }

    it { is_expected.to eq('module') }

    shared_context 'when the namespace is defined' do |namespace_name|
      before do
        FileUtils.mkdir_p('out') unless File.directory?('out')
        FileUtils.cp "spec/fixtures/#{namespace_name}.rb", "out/#{namespace_name}.rb"
        FileUtils.cp 'spec/fixtures/my_module.rb', 'out/my_module.rb'
      end

      after do
        File.delete("out/#{namespace_name}.rb")
        File.delete('out/my_module.rb')
      end
    end

    context 'when the constant is defined as `class`' do
      include_context 'when the namespace is defined', 'my_class_namespace'

      it { is_expected.to eq('class') }
    end

    context 'when the constant is defined as `module`' do
      let(:name) { 'MyModuleNamespace' }
      let(:entity_constants) { %w[MyModuleNamespace MyClass] }

      include_context 'when the namespace is defined', 'my_module_namespace'

      it { is_expected.to eq('module') }
    end

    context 'when the constant is defined as `Struct`' do
      let(:name) { 'MyStructNamespace' }
      let(:entity_constants) { %w[MyStructNamespace MyClass] }

      include_context 'when the namespace is defined', 'my_struct_namespace'

      it { is_expected.to eq('class') }
    end
  end
end
