require 'sinatra/base'
require 'sinatra/namespace'
require './controllers/user_controller'
require './controllers/post_controller'

class UserRoutes < Sinatra::Base
  register Sinatra::Namespace

  configure do
    set :user_controller, UserController.new
    set :post_controller, PostController.new
  end

  namespace '/user' do
    post '/' do
      user_data = {
        username: params['username'],
        email: params['email']
      }
      settings.user_controller.sign_up!(user_data)
    end
    post '/:username/posts' do
      post_data = {
        username: params['username'],
        text: params['text'],
        timestamp: Time.now,
        comment_on: params['comment_on']
      }
      settings.post_controller.post!(post_data)
    end
  end
end
