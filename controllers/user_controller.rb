require './models/user'

class UserController
  def initialize(model = User)
    @model = model
  end

  def sign_up!(request_data)
    user = @model.new(request_data)
    user.save
  rescue UserError::UserInvalidError => e
    { status: 400, body: e.message }
  else
    { status: 201, body: '' }
  end
end
