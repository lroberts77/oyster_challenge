class Journey

attr_reader :entry_station, :exit_station
PENALTY_CHARGE = 6
MINIMUM_FARE = 1

def initialize
  @entry_station = nil
  @exit_station = nil
end

def start_journey(entry_station)
  @entry_station = entry_station
end

def finish_journey(exit_station)
  @exit_station = exit_station
end

def calculate_fare
  entry_station == nil || exit_station == nil ? PENALTY_CHARGE : MINIMUM_FARE
end

def in_journey?
  @entry_station != nil && @exit_station == nil
end

end