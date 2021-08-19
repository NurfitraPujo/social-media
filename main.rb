require 'sinatra/base'
require 'sinatra/reloader'
require 'config'

require './routes/user_routes'
require './routes/post_routes'

class App < Sinatra::Application
  configure :development do
    register Sinatra::Reloader
  end

  set :root, __dir__
  register Config

  set :bind, Settings.HOST
  set :port, Settings.PORT


  use UserRoutes
  use PostRoutes

  run! if __FILE__ == $0
end
