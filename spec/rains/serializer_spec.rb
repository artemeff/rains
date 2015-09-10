describe Rains::Serializer do
  before do
    module User
      class Serializer < Rains::Serializer
        attribute :name, String
        attribute :age, Integer
      end
    end
  end

  after(:all) { Object.send(:remove_const, :User) }

  context '#to_json' do
    it 'returns json string' do
      serializer = User::Serializer.new(name: 'john', age: 21)

      expect(serializer.to_json).to eq('{"name":"john","age":21}')
    end

    it 'uses as interface to json libs' do
      serializer = User::Serializer.new(name: 'john', age: 21)

      expect(JSON.dump(serializer)).to eq('{"name":"john","age":21}')
    end
  end
end
