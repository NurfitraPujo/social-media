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
        allow(hashtag_mock).to receive(:new).with(hashtag: 'hashtag' ).and_return(hashtag_mock)
        allow(hashtag_mock).to receive(:save)

        post = Post.new(post_data)
        post.save_hashtags(hashtags, hashtag_mock)
        
        expect(hashtag_mock).to have_received(:save).once
      end
    end
  end
end
