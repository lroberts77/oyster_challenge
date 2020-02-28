require 'oyster.rb'
describe Oystercard do

  let(:oystercard) { Oystercard.new }
  let(:entry_station) { double :entry_station } # :entry station can be String
  let(:exit_station) { double :exit_station } # :entry station can be String

  it 'Oystercard has default balance of zero' do
    expect(subject.balance).to eq(0)
  end
  # it 'top_up method which adds money to my Oysercard balance' do
  #   expect(subject.top_up(5)).to eq(5)
  # end
  context 'when balance is above £90' do 
    it 'top_up method rasies error' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect { subject.top_up(1) }.to raise_error "Balance cannot exceed #{Oystercard::MAXIMUM_BALANCE}"
    end
  end
  it 'can touch in' do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_in(entry_station)
    expect(subject.current_trip).not_to eq(nil)
  end
  context 'when below minimum balance of £1' do
    it 'touch in method raises error' do
      expect{ subject.touch_in(entry_station) }.to raise_error "Top up mare than £#{Oystercard::MINIMUM_BALANCE} to use card for travel"
    end
  end
  it 'will charge me when I touch out' do
    subject.top_up(10)
    subject.touch_in("Enfield Town")
    expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::STANDARD_CHARGE)
  end
  # #In order to pay for my journey As a customer I need to know where
  #  I've travelled from
  it "expects to know where I've travelled from" do
    subject.top_up(Oystercard::MAXIMUM_BALANCE)
    subject.touch_in(entry_station)
    expect(subject.current_trip.entry_station).to eq(entry_station)
  end
  it "can check my default journey history that should be empty" do
    expect(subject.journeys).to eq []
  end
  context "that has completed a journey" do
    #creating a context block so the before block (that is right below this message) doesnt get applied to
    #the above tests.
    before do
      # the before block will run this code before each and every one of the following test, that
      # are in this block (testing a complete journey)
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end
    it 'can touch out and not be in journey' do
      expect(subject.current_trip).to eq(nil)
    end
    it "expects to forget entry station when tapping out" do
      # we dont want to keep the entry station when tapping out, so in the method touch out, we should
      # set the entry station to nil, like it started with
      expect(subject.entry_station).to eq nil
    end
    # it "has a penalty fare" do
    #   expect(subject.calculate_fare).to eq Journey::PENALTY_CHARGE
    # end
    it "should save a journey if you touch in twice" do
      subject.touch_in(entry_station)
      subject.touch_in(entry_station)
      expect(subject.journeys.length).to eq(2)
    end
  end
end