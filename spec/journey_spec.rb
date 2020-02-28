require 'journey'
describe Journey do
  let(:station) { double :station }
    it 'checks that a journey has been instantiated' do
        expect(subject).to eq subject
    end
    it 'initially not in journey' do
        expect(subject).not_to be_in_journey
    end
    describe "#calculate_fare" do
      it "returns a penalty charge when journey isn't touched out" do
        subject.start_journey("Harrow")
        expect(subject.calculate_fare).to eq(Journey::PENALTY_CHARGE)
      end
      it "returns a penalty fare when you've touched out but not touched in" do
        subject.finish_journey("Aldgate")
        expect(subject.calculate_fare).to eq(Journey::PENALTY_CHARGE)
      end
      it "expects you to pay the minimum fare if you touched in and out correctly." do
        subject.start_journey("Harrow")
        subject.finish_journey("Aldgate")
        expect(subject.calculate_fare).to eq(Journey::MINIMUM_FARE)
    end
    end
  end