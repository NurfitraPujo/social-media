require './spec/test_helper'
require './helpers/validations'

class DummyClass
  include Validations
end

describe Validations do
  describe '#email_valid?' do
    before(:all) do
      @dc = DummyClass.new
    end
    context 'given valid email' do
      it 'should return true' do
        email = 'fitra@gigih.com'
        expect(@dc.email_valid?(email)).to eq(true)
      end
    end
    context 'given invalid email' do
      it 'should return false' do
        email = 'fitra'
        expect(@dc.email_valid?(email)).to be_falsey
      end
    end
  end
end
