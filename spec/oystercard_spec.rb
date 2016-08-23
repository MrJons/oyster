require 'oystercard'

describe Oystercard do
    subject(:oystercard) {described_class.new}
    let(:amount) { double :amount }
      let(:station) { double :station }

  describe 'Initializing a card' do

    it 'card has a balance of zero' do
      expect(oystercard.instance_variable_get(:@balance)).to eq Oystercard::BALANCE
    end
    it 'is #in_journey' do
      expect(oystercard.in_journey?).to be false
    end
  end

  describe '#top_up' do

    context 'when under limit' do
    it 'responds to top-up with one argument' do
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end
    it 'can increase the balance' do
      expect{oystercard.top_up 10}.to change{oystercard.instance_variable_get(:@balance)}.by 10
    end
  end

    context 'when over limit' do
    it 'raises an error when more than £90 is added' do
      LIMIT = Oystercard::LIMIT
      oystercard.top_up(LIMIT)
      expect{ oystercard.top_up 5 }.to raise_error "Limit £#{LIMIT} exceeded"
    end
  end
  end

  context 'when travelling' do

    describe 'Checking impact touch in and out' do
      before do
        oystercard.top_up(10)
        oystercard.touch_in(station)
      end
      it 'In journey when touch in' do
        expect(oystercard).to be_in_journey
      end

      it 'Not in journey anymore when touch out' do
        oystercard.touch_out(2)
        expect(oystercard).not_to be_in_journey
      end

      it 'check a charge is made when touch out' do
        expect {oystercard.touch_out(2)}.to change{oystercard.instance_variable_get(:@balance)}.by(-2)
      end
    end
  end

  describe 'error messages' do
    it 'raises an error when balance is less than minimum balance' do
      expect { oystercard.touch_in(station) }.to raise_error 'below minimum balance'
    end
  end
  describe 'add station to card when touching in' do
    it 'add attributes' do
      oystercard.top_up(20)
      expect(oystercard).to respond_to(:touch_in).with(1).argument
    end
    it 'stores station argument in @entry_station' do
      oystercard.top_up(20)
      oystercard.touch_in(station)
      expect(oystercard.instance_variable_get(:@entry_station)).to eq station
    end  
  end
end
