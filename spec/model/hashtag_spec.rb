require './models/hashtag'

describe Hashtag do
  context 'when created' do
    it 'does have at least 1 occurence' do
      hashtag = Hashtag.new(hashtag: 'testhashtag')
      expect(hashtag.occurence).to be >= 1
    end
    it 'does define timestamp of when it was created' do
      hashtag = Hashtag.new(hashtag: 'testhashtag')
      expect(hashtag.instance_variable_defined?(:@last_updated)).to eq(true)
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
  describe '#save' do
    before(:each) do
      db_con = DatabaseConnection.instance
      db_con.query('DELETE FROM hashtag')
    end
    after(:all) do
      db_con = DatabaseConnection.instance
      db_con.query('DELETE FROM hashtag')
    end
    context 'when object is valid' do
      context 'and when object is unique' do
        it 'does create a new record on the persistence' do
          hashtag = Hashtag.new(hashtag: 'testhashtag')
          hashtag.save
          hashtags = Hashtag.all
          expect(hashtags.size).to eq(1)
        end
      end
    end
    context 'when object is invalid' do
      it 'does not create a new record' do
        hashtag = Hashtag.new
        hashtag.save
        hashtags = Hashtag.all
        expect(hashtags.size).to be_zero
      end
    end
  end
end
