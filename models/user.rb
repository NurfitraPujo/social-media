class User
  attr_reader :username, :email, :bio
  
  def initialize(user_data = {})
    @username = user_data[:username]
    @email = user_data[:email]
    @bio = user_data[:bio]
  end
end
