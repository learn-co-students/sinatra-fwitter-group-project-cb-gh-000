class UsersController < ApplicationController

  get '/' do
    'Welcome to Fwitter'
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'user/signup'
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'user/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    @user = user.authenticate(params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'user/show'
  end

end
