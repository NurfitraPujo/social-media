describe 'Post' do
  describe '#save_hashtags' do
    context 'when post includes hashtag' do
      it 'does save hashtags data' do
        post_data = {
          username: 'fitra',
          text: 'this post does have #hashtag',
          timestamp: DateTime.now
        }
        hashtags = ['hashtag']

        hashtag_mock = double('HashtagMock')
        allow(hashtag_mock).to receive(:new).with(hashtag: 'hashtag').and_return(hashtag_mock)
        allow(hashtag_mock).to receive(:save)

        post = Post.new(post_data)
        post.save_hashtags(hashtags, hashtag_mock)

        expect(hashtag_mock).to have_received(:save).once
      end
    end
    context 'when post includes n hashtags' do
      it 'does call collaborator save method n times' do
        post_data = {
          username: 'fitra',
          text: 'this post does have #hashtag #hashtag1',
          timestamp: DateTime.now
        }
        hashtags = %w[hashtag hashtag1]

        hashtag_mock = double('HashtagMock')
        allow(hashtag_mock).to receive(:new).and_return(hashtag_mock)
        allow(hashtag_mock).to receive(:save)

        post = Post.new(post_data)
        post.save_hashtags(hashtags, hashtag_mock)

        expect(hashtag_mock).to have_received(:save).twice
      end
    end
  end
  describe '#save' do
    let(:glob_db_con) { DatabaseConnection.instance }
    before(:all) do
      db_con = DatabaseConnection.instance
      db_con.query("INSERT INTO user(username, email) VALUE ('fitra', 'fitra@gmail.com')")
      db_con.query("INSERT INTO hashtag(hashtag, occurence) VALUES ('hashtag', 1)")
      db_con.query("INSERT INTO hashtag(hashtag, occurence) VALUES ('hashtag1', 1)")
    end
    before(:each) do
      db_con = DatabaseConnection.instance
      db_con.query('DELETE FROM post_have_hashtags')
    end
    after(:all) do
      db_con = DatabaseConnection.instance
      db_con.query('DELETE FROM post_have_hashtags')
      db_con.query('DELETE FROM post')
      db_con.query('DELETE FROM user')
      db_con.query('DELETE FROM hashtag')
    end
    context 'when post have hashtags' do
      it 'does save the post -> hashtag relationship map' do
        post_data = {
          username: 'fitra',
          text: 'this post does have #hashtag #hashtag1',
          timestamp: DateTime.now
        }

        post = Post.new(post_data)

        last_insert_id = 0
        glob_db_con.query('SELECT LAST_INSERT_ID() as id FROM post').each do |last_id|
          last_insert_id = last_id[:id]
        end
        post.save
        new_relation_count = glob_db_con.query('SELECT * FROM post_have_hashtags')
        expect(new_relation_count.count).to eq(2)
      end
    end
  end
end
