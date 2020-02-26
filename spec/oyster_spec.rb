require './lib/oyster.rb'

describe Oyster_card do

  let(:station) {:station}

    #As a customer I want money on my card
    it "oyster_card has a balance of zero" do
      expect(subject.balance).to eq(0)
    end
    describe "#top_up" do
      it { is_expected.to respond_to(:top_up).with(1).argument }
    end
    describe "#deduct" do
      it { is_expected.to respond_to(:deduct).with(1).argument }
    end

    it "can top up the balance" do
        expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it "can deduct from the balance" do
        subject.top_up(5)
      expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
    end

    it "raises an error when topup exceeds limit" do
      maximum_balance = Oyster_card::MAXIMUM_BALANCE
      subject.top_up(90)
      expect { subject.top_up 15 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end

    #it "raises an error when deduction balance exceeds zero" do
        # minimun_balance = Oyster_card::MINIMUM_BALANCE
        # # subject.top_up(minimun_balance)
        it "raises an error when trying to #touch_in when balance is < 1" do
          subject.instance_variable_set(:@balance, 0)
          expect { subject.touch_in(station) }.to raise_error "Top_up more than £#{Oyster_card::MINIMUM_BALANCE} to use card for travel"
        end

    describe "#touch_in" do

      it "checks if card has been used to #touch_in" do
        subject.instance_variable_set(:@balance, 10)
        subject.touch_in(station)
        expect(subject.in_journey?).to eq true
      end
    end

    describe "#touch_out" do

      it "checks if card has been used to #touch_out" do
        subject.instance_variable_set(:@balance, 10)
        subject.touch_out(station)
        expect(subject.in_journey?).to eq false
      end
    end

      it "when card is #touch_out deduct amount from balance" do
        subject.top_up(10)
        subject.touch_in(station)
        expect { subject.touch_out(station) }.to change {subject.balance}.by(-Oyster_card::MINIMUM_BALANCE)
      end

      it "stores the entry station" do
        subject.top_up(10)
        subject.touch_in(station)
        expect(subject.entry_station).to eq (station)
      end

      it "show the card has no journeys by default" do
        expect(subject.history).to eq []
      end

      it "checks that touching in and out creates a journey" do
        subject.top_up(10)
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject.history).to eq [{ in: station, exit: station }]
      end


    describe "#in_journey" do

      it "checks to make sure the card is not initially in_journey?" do
      expect(subject.in_journey?).to eq false
      end
    end
end