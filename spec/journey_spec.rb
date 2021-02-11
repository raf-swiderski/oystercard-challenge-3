require 'journey'

describe Journey do

  before(:each) do
    @journey = Journey.new('Clapham', 'Woking')
  end

  it 'knows the name of the entry station' do
    expect(@journey.entry_station).to eq 'Clapham'
  end

  it 'knows the name of the exit station' do
    expect(@journey.exit_station).to eq 'Woking'
  end

  it 'knows the fare of the journey' do
    expect(@journey.fare).to eq 1
  end

  describe '#fare_calc' do

    it 'charges a penalty, if there is no entry or exit station' do
      @journey = Journey.new('Clapham', nil)
      expect(@journey.fare_calc).to eq 6
    end

  end
end
