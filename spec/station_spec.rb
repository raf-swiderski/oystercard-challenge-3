require 'station'

describe Station do

  it 'knows the name zone of the station' do
    station = Station.new(2, "Victoria")
    expect(station.zone).to eq 2
  end

  it 'knows the name of the station' do
    station = Station.new(2, "Victoria")
    expect(station.name).to eq "Victoria"
  end
end