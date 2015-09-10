describe Rains::Service do
  include_context 'preloaded translations'

  before do
    module User
      class Create < Rains::Service
        attribute :name, String
        attribute :age, Integer, required: false
      end

      class EmptyCreate < Create
        def action
        end
      end

      class SampleDependency < Rains::Service
        def action
          true
        end
      end

      class EnhancedCreate < Create
        CreateError = Class.new(Rains::Service::Error)

        def action
          raise CreateError
        end
      end

      class Depends < Rains::Service
        depends_on :sample, SampleDependency

        def action
          sample.new.call!
        end
      end

      class BrokenDepends < Rains::Service
        depends_on :create, EnhancedCreate

        def action
          create.new(name: 'john').call
        end
      end
    end
  end

  after { Object.send(:remove_const, :User) }

  context '#call' do
    it 'raises NotImplementedError for default action' do
      expect {
        User::Create.new(name: 'john').call
      }.to raise_error(NotImplementedError)
    end

    it 'returns Service::Result' do
      result = User::EmptyCreate.new(name: 'john').call

      expect(result).to be_a(Rains::Service::Result)
    end

    it 'returns Service::Result::Success for success actions' do
      result = User::EmptyCreate.new(name: 'john').call

      expect(result).to be_a(Rains::Service::Result::Success)
    end

    it 'returns Service::Result::Fail for failed actions' do
      result = User::EnhancedCreate.new(name: 'john').call

      expect(result).to be_a(Rains::Service::Result::Fail)
    end

    it 'uses service dependency' do
      result = User::Depends.new.call

      expect(result.value).to eq(true)
    end

    it 'throws error when dependency fails' do
      result = User::BrokenDepends.new.call!

      expect(result.error).to be_a(User::EnhancedCreate::CreateError)
    end

    context '#value' do
      it 'returns nothing for empty action' do
        result = User::EmptyCreate.new(name: 'john').call

        expect(result.value).to eq(nil)
      end
    end

    context '#error' do
      it 'returns error when raises error in action' do
        result = User::EnhancedCreate.new(name: 'john').call

        expect(result.error).to be_a(User::EnhancedCreate::CreateError)
      end

      it 'contains translation for raised error' do
        result = User::EnhancedCreate.new(name: 'john').call

        expect(result.error.translate).to eq('something went wrong')
      end
    end
  end

  context '#call!' do
    it 'raises NotImplementedError for default action' do
      expect {
        User::Create.new(name: 'john').call!
      }.to raise_error(NotImplementedError)
    end

    it 'raises error for any custom errors' do
      expect {
        User::EnhancedCreate.new(name: 'john').call!
      }.to raise_error(User::EnhancedCreate::CreateError)
    end
  end
end
