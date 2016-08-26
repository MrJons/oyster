#Creates the current journey and assigns corresponding fare.

class Journey

  attr_reader :entry_station, :exit_station, :journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
  end

  def finish_journey(exit_station = nil)
    @exit_station = exit_station
    @journey = {:entry_station => @entry_station , :exit_station => exit_station}
  end

  def fare
    if @exit_station == nil || @entry_station == nil
      PENALTY_FARE
    else
      MINIMUM_FARE + (exit_station.zone - entry_station.zone).abs
    end
  end

end
