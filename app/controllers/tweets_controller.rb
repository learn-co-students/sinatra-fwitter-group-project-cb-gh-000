class TweetsController < ApplicationController

  get '/tweets' do
    @user = User.find_by_id(session[:user_id])
    erb :'tweets/index'
  end

end
