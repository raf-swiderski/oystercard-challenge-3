require_relative 'journey'

class Oystercard
  attr_reader :balance, :limit, :in_use, :entry_station, :journeys
  LIMIT = 90
  Min_Balance = 1
  Min_Fare = 1

  def initialize
    @balance = 0
    @limit = LIMIT
    @in_use = false
    @entry_station = nil
    @journeys = []
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

  #is it necessary to use both in_journey and in_use
  #(they are both booleans showing the same thing)

  def in_journey?
    return true if @entry_station
    false
  end

  def tap_in(station = 'Unknown entry station')
    fail "Mininum balance of #{Min_Balance} required to travel" if @balance < Min_Balance
    @entry_station = station
    in_journey?
  end

  def tap_out(station = 'Unknown exit station')
    deduct(Min_Fare)
    in_journey?
    @journeys << { entry_station: @entry_station, exit_station: station }
    @entry_station = nil
  end

  end
