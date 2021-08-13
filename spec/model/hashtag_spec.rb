require './models/hashtag'

describe Hashtag do
  describe '#valid?' do
    context 'when all required properties is present' do
      it 'does return true' do
        hashtag = Hashtag.new('testhashtag')
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
