require './models/post'

describe Post do
  describe '#valid?' do
    context 'when all required properties is present' do
      it 'does return true' do
        curr_time = Time.now
        post_data = {
          username: 'fitra',
          text: 'This is post example',
          timestamp: curr_time
        }
        post = Post.new(post_data)
        expect(post.valid?).to eq(true)
      end

      context 'when text does not contain anything' do
        it 'does return false if empty' do
          post_data = {
            username: 'fitra',
            text: ''
          }
          post = Post.new(post_data)
          expect(post.valid?).to be_falsey
        end

        it 'does return false if only contains space' do
          post_data = {
            username: 'fitra',
            text: ' '
          }
          post = Post.new(post_data)
          expect(post.valid?).to be_falsey
        end
      end
    end
    context 'when not all required properties is present' do
      it 'does return false' do
        post_data = {
          username: 'fitra'
        }
        post = Post.new(post_data)
        expect(post.valid?).to be_falsey
      end
    end
  end

  describe '#save' do
    before(:each) do
      db_con = DatabaseConnection.instance
      db_con.query('DELETE FROM post')
    end
    after(:all) do
      db_con = DatabaseConnection.instance
      db_con.query('DELETE FROM post')
    end
    context 'when post data is valid' do
      it 'does save post in the system' do
        curr_time = Time.now
        post_data = {
          username: 'fitra',
          text: 'testing post',
          timestamp: curr_time
        }
        post = Post.new(post_data)
        post.save
        posts = Post.all

        expect(posts.size).to eq(1)
      end
    end
  end
  describe '#include_hashtags?' do
    context 'when post have hashtags' do
      it 'does return true' do
        curr_time = Time.now
        post_data = {
          username: 'fitra',
          text: 'this post does have #hashtag',
          timestamp: curr_time
        }
        post = Post.new(post_data)
        expect(post.include_hashtags?).to eq(true)
      end
    end

    context 'when post does not have hashtags' do
      it 'does return false' do
        curr_time = Time.now
        post_data = {
          username: 'fitra',
          text: 'this post does not have hashtag',
          timestamp: curr_time
        }
        post = Post.new(post_data)
        expect(post.include_hashtags?).to be_falsey
      end
    end
  end
  describe '#extract_hashtags' do
    context 'when post have hashtags' do
      it 'does return an array of unique hashtag' do
        curr_time = Time.now
        post_data = {
          username: 'fitra',
          text: 'this post does have #hashtag #hashtag1 #hashtag1',
          timestamp: curr_time
        }
        expected_hashtags = %w[hashtag hashtag1]
        post = Post.new(post_data)
        actual_hashtags = post.extract_hashtags
        expect(actual_hashtags).to eq(expected_hashtags)
      end
    end
  end
end
