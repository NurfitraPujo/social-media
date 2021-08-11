require './helpers/validations'
require './lib/db_connector'

module UserError
  class UserInvalidError < ArgumentError
    def message
      'Invalid or undefined required properties'
    end
  end
end

class User
  include Validations
  include UserError
  attr_reader :username, :email, :bio

  def initialize(user_data = {}, db_con = DatabaseConnection.instance)
    @username = user_data[:username]
    @email = user_data[:email]
    @bio = user_data[:bio]
    @db_con = db_con
  end

  def valid?
    return false if @username.nil?
    return false if @email.nil?
    return false unless email_valid?(email)

    true
  end

  def save()
    raise UserInvalidError unless valid?

    @db_con.query("INSERT into user(username, email, bio)
                   VALUES ('#{@username}', '#{email}', '#{@bio}')")
  end

  def self.parse_raw(raw_user_data)
    users = []
    raw_user_data.each do |user_data|
      user = User.new(user_data)
      users << user
    end
    users
  end

  def self.all(db_con = DatabaseConnection.instance)
    raw_user_data = db_con.query('SELECT * FROM user')
    parse_raw(raw_user_data)
  end
end
