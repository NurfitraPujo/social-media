require 'sinatra/base'
require 'sinatra/reloader'
require 'config'

require './routes/user_routes'

class App < Sinatra::Application
  configure :development do
    register Sinatra::Reloader
  end

  set :root, __dir__
  register Config

  set :bind, Settings.HOST
  set :port, Settings.PORT

  use UserRoutes

  run! if __FILE__ == $0
end
