class Oyster_card

    MAXIMUM_BALANCE = 90

    attr_reader :balance

    def initialize
       @balance = 0
    end

    def top_up(amount)
      maximum_balance = MAXIMUM_BALANCE
      fail "Maximum balance of #{maximum_balance} exceeded" if amount + balance > MAXIMUM_BALANCE
      @balance += amount
    end
end
