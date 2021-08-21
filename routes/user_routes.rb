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
      attachment = nil
      if params['attachment']
        attachment = params['attachment']['filename']
        file = params['attachment']['tempfile']
        path = "./public/uploads/#{Time.now.to_i}_#{attachment}"

        File.open(path, 'wb') do |f|
          f.write(file.read)
        end

      end
      post_data = {
        username: params['username'],
        text: params['text'],
        timestamp: Time.now,
        comment_on: params['comment_on'],
        attachment: attachment
      }
      settings.post_controller.post!(post_data)
    end
  end
end
