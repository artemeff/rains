describe Rains::Form do
  include_context 'preloaded translations'

  before do
    module User
      class IsAdult < Rains::Assertion
        attribute :age

        def check
          return true if age.nil?

          age >= 18
        end
      end

      class IsNameValid < Rains::Assertion
        attribute :name

        def check
          (3..20).include?(name.size)
        end
      end

      class Form < Rains::Form
        attribute :name, String
        attribute :age, Integer, required: false

        assertions IsAdult, IsNameValid
      end
    end
  end

  after { Object.send(:remove_const, :User) }

  context '#validate' do
    it 'returns truthy state' do
      form = User::Form.new(name: 'john', age: 18)
      result = form.validate

      expect(result.valid?).to eq(true)
      expect(result.messages).to eq([])
    end

    it 'returns one falsy with custom translation' do
      form = User::Form.new(name: 'jane', age: 16)
      result = form.validate

      expect(result.valid?).to eq(false)
      expect(result.messages).to eq(['User is a child (age 16)'])
    end

    it 'skips age validating' do
      form = User::Form.new(name: 'jane')
      result = form.validate

      expect(result.valid?).to eq(true)
    end

    it 'throws error when required attribute not provided' do
      expect {
        User::Form.new
      }.to raise_error(Virtus::CoercionError)
    end
  end
end
