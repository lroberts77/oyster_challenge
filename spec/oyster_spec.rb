require'./lib/oyster.rb'
describe Oyster_card do
    
    #As a customer I want money on my card
    it "oyster_card has a balance of zero" do
      expect(subject.balance).to eq(0)
    end
    describe "#top_up" do
      it { is_expected.to respond_to(:top_up).with(1).argument }
    end
    
    it "can top up the balance" do
        expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
   
end