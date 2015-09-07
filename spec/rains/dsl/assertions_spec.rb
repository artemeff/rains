describe Rains::DSL::Assertions do
  it 'extend defines new method' do
    simple = Class.new

    expect(simple.instance_methods).not_to include(:assertions)
    expect(simple).to receive(:define_method) { :__assertions__ }

    simple.class_eval { extend Rains::DSL::Assertions }
  end

  it 'has empty assertions by default' do
    simple = Class.new do
      extend Rains::DSL::Assertions
    end

    expect(simple.new.__assertions__).to eq([])
  end

  it 'defines list of assertions when use dsl' do
    simple = Class.new do
      extend Rains::DSL::Assertions

      assertions :one, :two
    end

    expect(simple.new.__assertions__).to eq([:one, :two])
  end
end
