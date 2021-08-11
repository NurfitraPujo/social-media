require './spec/test_helper'
require './models/user'

describe User do
  describe '#initialize' do
    context 'when initialized given arguments' do
      it 'should return User instance with given properties' do
          user_data = {
              username: 'fitra',
              email: 'fitra@gigih.com',
              bio: 'mengerjakan projek akhir'
          }
          user = User.new(user_data)
          expect(user.username).to eq(user_data[:username])
          expect(user.email).to eq(user_data[:email])
          expect(user.bio).to eq(user_data[:bio])
      end 
    end
  end
end
