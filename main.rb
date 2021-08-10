require 'sinatra/base'
require 'sinatra/reloader'
require 'config'

class App < Sinatra::Application
  configure :development do
    register Sinatra::Reloader
  end

  set :root, __dir__
  register Config

  set :bind, Settings.HOST
  set :port, Settings.PORT

  get '/' do
    puts Settings.HOST
    'Hello world'
  end

  run! if __FILE__ == $0
end
