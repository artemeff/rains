describe Rains::DSL::Translation do
  include_context 'preloaded translations'

  before do
    module Test
      module Nested
        class NamedEntity
          include Rains::DSL::Translation
        end
      end
    end
  end

  subject { Test::Nested::NamedEntity.new }

  after { Object.send(:remove_const, :Test) }

  it 'defines new methods' do
    empty = Class.new
    methods = empty.instance_methods

    expect(methods).not_to include(:translate)
    expect(methods).not_to include(:translation_key)
    expect(methods).not_to include(:translation_class)
    expect(methods).not_to include(:translation_root)
  end

  it 'defined new methods' do
    methods = subject.methods

    expect(methods).to include(:translate)
    expect(methods).to include(:translation_key)
    expect(methods).to include(:translation_class)
    expect(methods).to include(:translation_root)
  end

  it '#translation_root' do
    expect(subject.translation_root).to eq(:rains)
  end

  it '#translation_class' do
    expect(subject.translation_class).to eq('test.nested.named_entity')
  end

  it '#translation_key' do
    expect(subject.translation_key).to eq('rains.test.nested.named_entity')
  end

  it '#translate' do
    expect(subject.translate).to eq('test named entity')
  end
end
