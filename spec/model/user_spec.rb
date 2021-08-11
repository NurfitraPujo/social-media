require './spec/test_helper'
require './models/user'
require './lib/db_connector'

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

  describe '#valid?' do
    context 'when all required properties is given' do
      it 'should return true' do
        user_data = {
          username: 'fitra',
          email: 'fitra@gigih.com'
        }
        user = User.new(user_data)
        expect(user.valid?).to eq(true)
      end

      context 'when email is invalid' do
        it 'should return false' do
          user_data = {
            username: 'fitra',
            email: 'fitra'
          }
          user = User.new(user_data)
          expect(user.valid?).to eq(false)
        end
      end
    end

    context 'when not all required properties is given' do
      it 'should return false' do
        user_data = {
          username: 'fitra'
        }
        user = User.new(user_data)
        expect(user.valid?).to be_falsey
      end
    end
  end

  describe "#save" do
    before(:each) do
      db_con = DatabaseConnection.instance
      db_con.query('DELETE FROM user');
    end
    context "when called" do
      it 'does create new record to persistence' do
        user_data = {
          username: 'fitra',
          email: 'fitra@gigih.com'
        }
        user = User.new(user_data)
        user.save 
        users = User.all
        expect(users.size).to eq(1)
      end
    end
  end
end
