describe Rains::Helpers do
  context '#kind_of_service_class?' do
    let(:dummy) { Class.new(Rains::Service) }

    it 'false for not Rains::Service' do
      expect(subject.kind_of_service_class?(Class)).to eq(false)
    end

    it 'false for not primitives' do
      expect(subject.kind_of_service_class?(double)).to eq(false)
    end

    it 'true for Rains::Service' do
      expect(subject.kind_of_service_class?(dummy)).to eq(true)
    end
  end
end
