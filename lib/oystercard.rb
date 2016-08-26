require_relative 'journey'
require_relative 'Journeylog'

#Maintains a balance through touch in & touch out. Also records journey history, soon to be pulled out.

class Oystercard

MAXIMUM_LIMIT = 90
MINIMUM_LIMIT = 1

attr_reader :balance, :journeylog, :station

  def initialize(journeylog = Journeylog.new)
    @balance = 0
    @journeylog = journeylog
  end

  def top_up(amount)
    fail 'Top up limited exceeded' if amount + balance > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds. Please top up." if balance < MINIMUM_LIMIT
    @journeylog.start(station)
    deduct(journeylog.outstanding_fare)
  end

  def touch_out(station)
    @journeylog.finish(station)
    deduct(@journeylog.last_fare)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def stations
    station_names = ["Green park", "Aldgate", "Bank", "London Bridge", "Heathrow"].sample
    station_zones = [1,2,3,4,5].sample
    @station = Station.new(station_names, station_zones)
  end

end
