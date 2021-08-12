require 'sinatra/base'
require 'sinatra/namespace'
require './controllers/user_controller'

class UserRoutes < Sinatra::Base
  register Sinatra::Namespace

  configure do
    set :controllers, UserController.new
  end

  namespace '/user' do
    post '/' do
      user_data = {
        username: params['username'],
        email: params['email']
      }
      settings.controllers.sign_up!(user_data)
    end
  end
end
