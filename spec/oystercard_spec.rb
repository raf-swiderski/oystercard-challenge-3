require 'oystercard'

describe Oystercard do
  it 'has a balance of 0 by default' do
    expect(subject.balance).to eq(0)
  end
  it 'has a limit' do
    expect(subject.limit).to eq(90)
  end
  it 'has an `in_use` status of false' do
    expect(subject.in_use).to be false
  end

  describe '#top_up' do
    it 'should take a top_up value and add it to the card balance' do
      subject.top_up(10)
      expect(subject.balance).to eq (10)
    end
    it 'should raise an error if top_up returns more than 90' do
      oyster = Oystercard.new
      oyster.top_up(Oystercard::LIMIT)
      expect { subject.top_up(91) }.to raise_error("top up limit of #{Oystercard::LIMIT} exceeded")
    end
  end

  describe '#in_journey?' do
    it 'should return false if the oystercard isnt in use' do
      expect(subject.in_journey?).to eq false
    end
  #  it 'should return true if the oystercard is in use' do
  #    expect(subject.in_journey?).to eq true
  #  end
  end

  describe '#tap_in' do

  #  before(:all) do
  #    @oystercard = Oystercard.new
  #  end

    it 'should change in_journey? to true' do
      subject.top_up(20)
      expect{subject.tap_in}.to change{subject.in_journey?}.to true
    end
    it 'should fail if balance is less than 1' do
      expect{ subject.tap_in }.to raise_error "Mininum balance of #{Oystercard::Min_Balance} required to travel"
    end

  end

  describe '#tap_out' do

    before(:all) do
      @oystercard = Oystercard.new
    end

    it 'should change in_journey? to false' do
      @oystercard.top_up(20)
      @oystercard.tap_in
      expect { @oystercard.tap_out }.to change { @oystercard.in_journey? }.to false
    end

    it 'should deduct the balance by minimum fare' do
      oystercard = Oystercard.new
      oystercard.top_up(10)
      oystercard.tap_in
      oystercard.tap_out
      expect(oystercard.balance).to eq (9)
    end

  end

end
