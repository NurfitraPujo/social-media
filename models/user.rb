require './helpers/validations'

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
end
