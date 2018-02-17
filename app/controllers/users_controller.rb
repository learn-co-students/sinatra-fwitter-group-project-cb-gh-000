class UsersController < ApplicationController

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to "/tweets"
    else
      erb :"users/login"
    end
  end

  post '/login' do
    @user    = User.find_by(email: params[:email])
    password = Helpers.delete_spaces(params[:password])

    if @user.password == params[:password]
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to "/tweets"
    else
      erb :"users/create_user"
    end
  end

  post '/signup' do
      username = Helpers.delete_spaces(params[:username])
      password = Helpers.delete_spaces(params[:password])
      email    = Helpers.delete_spaces(params[:email])
      if username == "" || password == "" || email == ""
        redirect to "/signup"
      else
        @user = User.new
        @user.username = username
        @user.email = email
        @user.password = password
        @user.save
        session[:user_id] = @user.id
        redirect to "/tweets"
      end
  end

  get '/show' do
    current_user = session[:user_id]
    @user = User.find(current_user)
    erb :"users/show"
  end

  get '/logout' do
    session.clear
    erb :index
  end
end
