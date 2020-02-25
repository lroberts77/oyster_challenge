require'./lib/oyster.rb'

describe Oyster_card do

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

    it "raises an error when deduction balance exceeds zero" do
        # minimun_balance = Oyster_card::MINIMUM_BALANCE
        # subject.top_up(minimun_balance)
        subject.top_up(10)
        expect {subject.deduct 15}.to raise_error "Minimum balance of #{Oyster_card::MINIMUM_BALANCE} exceeded"
    end

    describe "#touch_in" do

      it "checks if card has been used to #touch_in" do
        subject.touch_in
        expect(subject.in_journey?).to eq true
      end
    end

    describe "#touch_out" do

      it "checks if card has been used to #touch_out" do
        subject.touch_out
        expect(subject.in_journey?).to eq false
      end
    end

    describe "#in_journey" do

      it "checks to make sure the card is not initially in_journey?" do
      expect(subject.in_journey?).to eq false
      end
    end
end