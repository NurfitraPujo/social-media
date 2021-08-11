require './spec/test_helper'
require './controllers/user_controller'

describe UserController do
  describe '#sign_up!' do
    context 'when user is new and valid' do
      it 'does register new user' do
        request_data = {
          username: 'fitra',
          email: 'fitra@gigih.com'
        }
        expected_response = {
          status: 201,
          body: ''
        }

        model = double
        allow(model).to receive(:new).with(request_data).and_return(model)
        allow(model).to receive(:save)

        user_co = UserController.new(model)
        response = user_co.sign_up!(request_data)
        expect(model).to have_received(:save)
        expect(response).to eq(expected_response)
      end
    end
    context 'when user is new but invalid' do
      it 'does not register user, and return error response' do
        request_data = {
          username: 'fitra'
        }
        expected_response = {
          status: 400,
          body: 'Invalid or undefined required properties'
        }

        model = double
        allow(model).to receive(:new).with(request_data).and_return(model)
        allow(model).to receive(:save).and_raise(UserError::UserInvalidError)

        user_co = UserController.new(model)
        response = user_co.sign_up!(request_data)
        expect(model).to have_received(:save)
        expect(response).to eq(expected_response)
      end
    end
  end
end
