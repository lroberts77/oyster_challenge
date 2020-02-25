class Oyster_card

    MAXIMUM_BALANCE = 90
    MINIMUM_BALANCE = 0

    attr_reader :balance, :status

    def initialize
       @balance = 0
       @status = false
    end

    def top_up(amount)
      fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if (amount + @balance) > MAXIMUM_BALANCE
      @balance += amount
    end

    def deduct(amount)
      #minimum_balance = MINIMUM_BALANCE
      fail "Minimum balance of #{MINIMUM_BALANCE} exceeded" if (@balance - amount) < MINIMUM_BALANCE
      @balance -= amount
    end

    def touch_in
      @status = true
    end

    def touch_out
      @status = false
    end

    def in_journey?
      @status
    end
end
