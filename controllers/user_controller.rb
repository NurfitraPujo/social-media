require './models/user'

class UserController
  def initialize(model = User)
    @model = model
  end

  def sign_up!(request_data)
    user = @model.new(request_data)
    user.save
    { status: 201, body: '' }
  end
end
