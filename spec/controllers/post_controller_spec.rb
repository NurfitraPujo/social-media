require './controllers/post_controller'

describe PostController do
  describe '#post!' do
    context 'when all required properties of Post is given' do
      it 'does save the post' do
        request_data = {
          username: 'fitra',
          text: 'This is example post',
          timestamp: Time.now
        }

        model = double
        allow(model).to receive(:new).with(request_data).and_return(model)
        allow(model).to receive(:save)

        post_co = PostController.new(model)
        post_co.post!(request_data)

        expect(model).to have_received(:save)
      end
    end
  end
end
