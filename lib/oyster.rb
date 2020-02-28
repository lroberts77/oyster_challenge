require_relative 'journey'
class Oystercard

  attr_reader :balance, :entry_station, :current_trip, :journeys

MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1
STANDARD_CHARGE = 1

  def initialize
    @balance = 0
    @current_trip = nil
    @journeys = []
  end

  def top_up(amount)
    fail "Balance cannot exceed #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Top up mare than £#{Oystercard::MINIMUM_BALANCE} to use card for travel" if balance < MINIMUM_BALANCE
    if @current_trip != nil
      @journeys << (@current_trip)
      deduct(@current_trip.calculate_fare)
    end
    @current_trip = Journey.new
    @current_trip.start_journey(entry_station)
  end
  
  def touch_out(exit_station)
    if @current_trip == nil
      @current_trip = Journey.new
      

    end
    @current_trip.finish_journey(exit_station)
    deduct(@current_trip.calculate_fare)
    @journeys << (@current_trip)
    @current_trip = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end
  # def limited_balance
  #   @balance < MINIMUM_BALANCE
  # end
end

