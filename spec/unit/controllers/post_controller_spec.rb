require './controllers/post_controller'

describe PostController do
  describe '#post!' do
    context 'when all required properties of Post is given' do
      it 'does save new post, and return success response' do
        request_data = {
          username: 'fitra',
          text: 'This is example post',
          timestamp: Time.now
        }
        expected_response = [201]

        model = double
        allow(model).to receive(:new).with(request_data).and_return(model)
        allow(model).to receive(:save)

        post_co = PostController.new(model)
        response = post_co.post!(request_data)

        expect(model).to have_received(:save)
        expect(response).to eq(expected_response)
      end
    end
    context 'when not all required properties is not given' do
      it 'does not save new post, and return bad request response' do
        request_data = {
          username: 'fitra',
          text: 'This is example post'
        }
        expected_response = [400, 'Invalid or undefined required properties']

        model = double
        allow(model).to receive(:new).with(request_data).and_return(model)
        allow(model).to receive(:save).and_raise(PostError::PostInvalidError)

        post_co = PostController.new(model)
        response = post_co.post!(request_data)

        expect(model).to have_received(:save)
        expect(response).to eq(expected_response)
      end
    end
  end

  describe '#search' do
    context 'when given hashtag' do
      it 'does return a success response, and an array of posts' do
        request_data = {
          hashtag: 'hashtag'
        }
        dummy_post = Post.new(
          username: 'fitra',
          text: 'this post have #hashtag',
          timestamp: DateTime.now
        )
        expected_response = [200, [dummy_post.to_json]]

        mock_model = double
        allow(mock_model).to receive(:where_hashtag).and_return([dummy_post])

        post_co = PostController.new(mock_model)
        actual_response = post_co.search(request_data)
        expect(actual_response).to eq(expected_response)
      end
    end
    context 'when not given arguments' do
      it 'does return bad request status' do
        request_data = {}
        expected_response = [400, 'No search parameters given']

        post_co = PostController.new
        actual_response = post_co.search(request_data)
        expect(actual_response).to eq(expected_response)
      end
    end
  end
end
