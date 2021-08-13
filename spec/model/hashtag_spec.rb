require './models/hashtag'

describe Hashtag do
  context 'when created' do
    it 'does have at least 1 occurence' do
      hashtag = Hashtag.new(hashtag: 'testhashtag')
      expect(hashtag.occurence).to be >= 1
    end
    it 'does define timestamp of when it was created' do
      hashtag = Hashtag.new(hashtag: 'testhashtag')
      expect(hashtag.instance_variable_defined?(:@timestamp)).to eq(true)
    end
  end
  describe '#valid?' do
    context 'when all required properties is present' do
      it 'does return true' do
        hashtag = Hashtag.new(hashtag: 'testhashtag')
        expect(hashtag.valid?).to eq(true)
      end
    end
    context 'when not all required properties is present' do
      it 'does return false' do
        hashtag = Hashtag.new
        expect(hashtag.valid?).to eq(false)
      end
    end
  end
end
