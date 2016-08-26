require 'journey'

describe Journey do

  subject(:journey) { described_class.new (entry_station) }
  subject(:journeydub) { described_class.new (entry_station) }
  subject(:journey_nil) {described_class.new}
  let(:entry_station) {double :entry_station, zone: 1}
  let(:exit_station) {double :exit_station, zone: 4}

  describe '#initialize' do
    it 'initializes with an recorded entry station' do
      expect(journey.entry_station).to eq entry_station
    end
  end

  describe '#finish_journey' do
    it 'records total journey' do
      expect(journey.finish_journey("Aldgate")).to eq({ :entry_station => entry_station , :exit_station => "Aldgate" })
    end
  end

  describe '#fare' do
    it "charges mimumum fare on full journey" do
      journey.finish_journey(exit_station)
      expect(journey.fare).to eq(4)
    end

    it "charges penalty fare on missing exit station" do
      expect(journey.fare).to eq(Journey::PENALTY_FARE)
    end

    it "charges penalty fare on missing entry station" do
      expect(journey_nil.fare).to eq(Journey::PENALTY_FARE)
    end

    it "charges fare based on zone" do
      journeydub.finish_journey(exit_station)
      expect(journeydub.fare).to eq(4)
    end
  end


end
