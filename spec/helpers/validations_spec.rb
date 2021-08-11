require './spec/test_helper'
require './helpers/validations'

class DummyClass
  include Validations
end

describe Validations do
  describe '#validate_email' do
    before(:all) do
      @dc = DummyClass.new
    end
    context 'given valid email' do
      it 'should return true' do
        email = 'fitra@gigih.com'
        expect(@dc.validate_email?(email)).to eq(true)
      end
    end
  end
end
