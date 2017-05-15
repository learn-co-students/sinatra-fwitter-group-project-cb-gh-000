require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  # Tweet routes

  get '/tweets' do
  end

  post '/tweets' do
  end

  get '/tweets/new' do
  end

  get '/tweets/:id/edit' do
  end

  get '/tweets/:id' do
  end

  patch '/tweets/:id' do
  end

  delete '/tweets/:id/delete' do
  end

  # User routes

  get '/signup' do
  end

  post '/signup' do
  end

  get '/login' do
  end

  post '/login' do
  end

  get '/logout' do
  end
end