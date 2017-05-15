require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  # Tweet routes

  get '/tweets' do
    erb :'tweets/tweets'
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
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      user = User.new
      user.username = params[:username]
      user.email = params[:email]
      user.password = params[:password]
      user.save!
    end

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
  end

  post '/login' do
  end

  get '/logout' do
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end