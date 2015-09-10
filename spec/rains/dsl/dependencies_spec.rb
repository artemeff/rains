describe Rains::DSL::Dependencies do
  before do
    module Test
      class SampleService < Rains::Service
        def action
          true
        end
      end

      class Sample
        extend Rains::DSL::Dependencies

        depends_on :sample, SampleService
      end
    end
  end

  subject { Test::Sample.new }

  after { Object.send(:remove_const, :Test) }

  it 'defines method for dependency' do
    expect(subject.sample).to eq(Test::SampleService)
  end

  it 'throw error when try to use not Rains::Service for dependency' do
    expect {
      Class.new do
        extend Rains::DSL::Dependencies

        depends_on :sample, Hash
      end
    }.to raise_error(TypeError, 'The Hash is not a Rains::Service')
  end
end
