require './spec/test_helper'
require './lib/db_connector'

describe 'DatabaseConnection' do
  context 'When testing' do
    it 'Environtment uset should be test' do
      db_con = DatabaseConnection.instance
      expect(db_con.environtment).to eq('test')
    end
  end
end
