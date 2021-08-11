require './helpers/validations'
require './lib/db_connector'

class User
  include Validations
  attr_reader :username, :email, :bio

  def initialize(user_data = {})
    @username = user_data[:username]
    @email = user_data[:email]
    @bio = user_data[:bio]
  end

  def valid?
    return false if @username.nil?
    return false if @email.nil?
    return false unless email_valid?(email)

    true
  end

  def save(db_con = DatabaseConnection.instance)
    return false unless valid?

    db_con.query("INSERT into user(username, email, bio)
                   VALUES ('#{@username}', '#{email}', '#{@bio}')")
  end

  def self.all(db_con = DatabaseConnection.instance)
    db_con.query('SELECT * FROM user')
  end
end
