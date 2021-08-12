require './models/user'

class UserController
  def initialize(model = User)
    @model = model
  end

  def sign_up!(user_data)
    user = @model.new(user_data)
    user.save
  rescue UserError::UserInvalidError => e
    [400, e.message]
  rescue UserError::UserAlreadyExistError => e
    [400, e.message]
  else
    [201]
  end
end
