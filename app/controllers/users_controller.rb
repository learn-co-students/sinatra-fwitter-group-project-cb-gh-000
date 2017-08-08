class UsersController < ApplicationController
  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      flash[:message] = 'Incorrect login details!'
      redirect to '/login'
    end
  end
end