require_relative 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station, :fare

  def initialize(entry_station, exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
    @fare = Oystercard::Min_Fare
  end

  # If there is an entry and exit station charge £1
  # If there is either no entry or exit station, then charge £6

  def fare_calc
    if @entry_station == nil || @exit_station == nil then @fare += 5
    end
    @fare
  end




end
