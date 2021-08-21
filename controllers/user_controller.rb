require './models/user'
require './helpers/parser'

class UserController
  include Parser

  def initialize(model = User)
    @model = model
  end

  def list!
    users = @model.all
    [200, to_json_arr(users)]
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
