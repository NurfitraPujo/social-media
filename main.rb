require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/json'
require 'config'

require './routes/user_routes'
require './routes/post_routes'
require './routes/hashtag_routes'

class App < Sinatra::Application
  configure :development do
    register Sinatra::Reloader
  end

  set :root, __dir__
  register Config

  set :bind, Settings.HOST
  set :port, Settings.PORT
  set :json_encoder, :to_json

  before do
    content_type :json
  end

  use UserRoutes
  use PostRoutes
  use HashtagRoutes

  run! if __FILE__ == $0
end
