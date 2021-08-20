require 'sinatra/base'
require 'sinatra/namespace'
require './controllers/hashtag_controller'

class HashtagRoutes < Sinatra::Base
  register Sinatra::Namespace

  configure do
    set :hashtag_controller, HashtagController.new
  end

  namespace '/hashtag' do
    get '/trending' do
      settings.hashtag_controller.trending_hashtags
    end
  end
end
