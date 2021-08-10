require 'sinatra/base'

class UserController < Sinatra::Base
  get '/user' do
    'This is user routes'
  end
end
