

class Oystercard
  attr_reader :balance, :limit, :in_use
  LIMIT = 90
  Min_Balance = 1
  Min_Fare = 1

  def initialize
    @balance = 0
    @limit = LIMIT
    @in_use = false
  end
  def top_up(value)
    projection = @balance + value
    raise "top up limit of #{LIMIT} exceeded" if projection > @limit
    @balance += value
  end

  private

  def deduct(value)
    @balance -= value
  end

  public

  #is it necessary to use both in_journey and in_use (they are both booleans showing the same thing)
  def in_journey?
    @in_use
  end

  def tap_in
    fail "Mininum balance of #{Min_Balance} required to travel" if @balance < Min_Balance
    @in_use = true
  end

  def tap_out
    @in_use = false
    deduct(Min_Fare)
  end

end
