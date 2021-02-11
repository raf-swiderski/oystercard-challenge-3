require 'oystercard'

describe Oystercard do

  before(:each) do
    @oystercard = Oystercard.new
  end

  it 'has a balance of 0 by default' do
    expect(@oystercard.balance).to eq(0)
  end
  it 'has a limit' do
    expect(@oystercard.limit).to eq(90)
  end
  it 'has an `in_use` status of false' do
    expect(@oystercard.in_use).to be false
  end

  describe '#top_up' do

    before(:each) do
      @oystercard = Oystercard.new
    end

    it 'should take a top_up value and add it to the card balance' do
      @oystercard.top_up(10)
      expect(@oystercard.balance).to eq (10)
    end
    it 'should raise an error if top_up returns more than 90' do
      expect { @oystercard.top_up(91) }.to raise_error("top up limit of #{Oystercard::LIMIT} exceeded")
    end
  end

  describe '#in_journey?' do
    it 'should return false if the oystercard isnt in use' do
      expect(subject.in_journey?).to eq false
    end

    it'should infer its status based on whether or not there is an entry station' do
      @oystercard = Oystercard.new
      @oystercard.top_up(10)
      @oystercard.tap_in
      expect(@oystercard.in_journey?).to eq true
    end

  end

  describe '#tap_in' do

    before(:each) do
      @oystercard = Oystercard.new
    end

    it 'should change in_journey? to true' do
      @oystercard.top_up(20)
      expect{@oystercard.tap_in}.to change{@oystercard.in_journey?}.to true
    end
    it 'should fail if balance is less than 1' do
      expect{ subject.tap_in }.to raise_error "Mininum balance of #{Oystercard::Min_Balance} required to travel"
    end
    it 'stores given station in @entry_station' do
      @oystercard.top_up(20)
      @oystercard.tap_in('Victoria')
      expect(@oystercard.entry_station).to eq 'Victoria'
    end


  end

  describe '#tap_out' do

    before(:each) do
      @oystercard = Oystercard.new
      @oystercard.top_up(10)
      @oystercard.tap_in('Victoria')
    end

    it 'should change in_journey? to false' do
      expect { @oystercard.tap_out }.to change { @oystercard.in_journey? }.to false
    end

    it 'should deduct the balance by minimum fare' do
      @oystercard.tap_out
      expect(@oystercard.balance).to eq (9)
    end

    it 'should store the stations in an array' do
      @oystercard.tap_out('Woking')
      expect(@oystercard.journeys.length).to eq 1
    end

    it 'should check that the card has an empty list of journeys by default' do
      expect(@oystercard.journeys).to eq []
    end

  end
end
