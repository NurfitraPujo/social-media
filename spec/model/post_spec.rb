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
end
