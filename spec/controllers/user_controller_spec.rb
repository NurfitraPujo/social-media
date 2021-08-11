require './spec/test_helper'
require './controllers/user_controller'

describe UserController do
  describe '#sign_up!' do
    context 'when called' do
      it 'does register new user' do
        request_data = {
          username: 'fitra',
          email: 'fitra@gigih.com'
        }
        model = double
        allow(model).to receive(:new).with(request_data).and_return(model)
        allow(model).to receive(:save)

        user_co = UserController.new(model)
        user_co.sign_up!(request_data)
        expect(model).to have_received(:save)
      end
    end
  end
end
