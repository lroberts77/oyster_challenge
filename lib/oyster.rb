class Oyster_card

    MAXIMUM_BALANCE = 90
    MINIMUM_BALANCE = 1

    attr_reader :balance, :status, :entry_station

    def initialize
       @balance = 0
       @status = false
       @entry_station = entry_station
    end

    def top_up(amount)
      fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if (amount + @balance) > MAXIMUM_BALANCE
      @balance += amount
    end

    def deduct(amount)
      #minimum_balance = MINIMUM_BALANCE
      @balance -= amount
    end

    def touch_in(station)
      raise "Top_up more than £#{Oyster_card::MINIMUM_BALANCE} to use card for travel" if balance < MINIMUM_BALANCE
      @status = true
      @entry_station = station
    end

    def touch_out(station)
      deduct(MINIMUM_BALANCE)
      @status
      @entry_station = nil
    end

    def in_journey?
      @status
    end
end
