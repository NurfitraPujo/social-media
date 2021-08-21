require './spec/test_helper'
require './controllers/user_controller'

describe UserController do
  describe '#list_user!' do
    context 'when called' do
      it 'does return success response and list of user' do
        user = [
          User.new(username: 'fitra', email: 'fitra@gmail.com')
        ]
        user_jsons = [
          User.new(username: 'fitra', email: 'fitra@gmail.com').to_json
        ]
        expected_response = [200, user_jsons]
        
        mock_model = double
        allow(mock_model).to receive(:all).and_return(user)

        user_co = UserController.new(mock_model)
        actual_response = user_co.list!

        expect(actual_response).to eq(expected_response)
      end
    end
  end
  describe '#sign_up!' do
    context 'when user is new and valid' do
      it 'does register new user' do
        request_data = {
          username: 'fitra',
          email: 'fitra@gigih.com'
        }
        expected_response = [201]

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
        expected_response = [
          400,
          'Invalid or undefined required properties'
        ]

        model = double
        allow(model).to receive(:new).with(request_data).and_return(model)
        allow(model).to receive(:save).and_raise(UserError::UserInvalidError)

        user_co = UserController.new(model)
        response = user_co.sign_up!(request_data)
        expect(model).to have_received(:save)
        expect(response).to eq(expected_response)
      end
    end
    context 'when data given already existed in the system' do
      before(:each) do
        user_co = UserController.new
        user_co.sign_up!({ username: 'fitra', email: 'fitra@gigih.com' })
      end
      it 'does not register user, and return error that user already exist' do
        request_data = {
          username: 'fitra',
          email: 'fitra@gigih.com'
        }
        expected_response = [
          400,
          'User already exist'
        ]

        user_co = UserController.new
        response = user_co.sign_up!(request_data)
        expect(response).to eq(expected_response)
      end
    end
  end
end
