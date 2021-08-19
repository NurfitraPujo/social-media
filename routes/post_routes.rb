require 'sinatra/base'
require 'sinatra/namespace'
require './controllers/post_controller'

class PostRoutes < Sinatra::Base
  register Sinatra::Namespace

  configure do
    set :post_controller, PostController.new
  end

  namespace '/post' do
    get '/' do
      search_params = {
        hashtag: params['hashtag']
      }
      settings.post_controller.search(search_params)
    end
  end
end
