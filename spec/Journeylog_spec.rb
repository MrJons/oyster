require "Journeylog"

describe Journeylog do

  let(:journey_class) {double :journey_class, new: journey}
  let(:journey) {double :journey, start: station}
  let(:entry_station) {double :entry_station, zone: 5}
  let(:exit_station) {double :exit_station, zone: 2}


  it "expects journey history to be empty" do
    expect(subject.journeys).to be_empty
  end

  it 'add a complete journey to journey history' do
    subject.start(entry_station)
    subject.finish(exit_station)
    expect(subject.journeys).to include({ :entry_station => entry_station , :exit_station => exit_station })
  end

  it "recieves correct fare" do
    subject.start(entry_station)
    subject.finish(exit_station)
    expect(subject.last_fare).to eq 4 #standard fare based on doubles
  end

  it 'add a incomplete journey to journey history' do
    subject.start(entry_station)
    subject.start(entry_station)
    expect(subject.journeys).to include({ :entry_station => entry_station , :exit_station => nil })
  end

  it 'records incomplete journey in journey history' do
    subject.finish(exit_station)
    expect(subject.journeys).to include({ :entry_station => nil , :exit_station => exit_station })
  end

  it 'forgets entry_station on touch out' do
    subject.start(entry_station)
    subject.finish(exit_station)
    expect(subject.journey).to eq nil
  end

  it 'resets outstanding_fare to zero after succesfully completing a journey' do
    subject.finish(exit_station)
    expect(subject.outstanding_fare).to eq 0
  end

end
