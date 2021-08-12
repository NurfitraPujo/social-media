require './models/post'

describe Post do
  describe '#valid?' do
    context 'when all required properties is present' do
      it 'does return true' do
        post_data = {
          username: 'fitra',
          text: 'This is post example'
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
        post_data = {
          username: 'fitra',
          text: 'testing post'
        }
        post = Post.new(post_data)
        post.save
        posts = Post.all

        expect(posts.size).to eq(1)
      end
    end
    context 'when post data is invalid' do
      it 'does not save post, and raise error' do
        post_data = {
          username: 'fitra',
          text: ''
        }
        post = Post.new(post_data)
        expect{ post.save }.to raise_error(PostError::PostInvalidError)
      end
    end
  end
end
