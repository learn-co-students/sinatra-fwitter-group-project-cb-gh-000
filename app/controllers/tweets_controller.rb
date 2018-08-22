class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    "New TWEETS"
  end

end
