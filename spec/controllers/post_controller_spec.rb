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
end
