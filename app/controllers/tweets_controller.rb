class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    new_tweet = Tweet.new(content: params[:content], user: current_user)
    if new_tweet.save
      redirect to '/tweets'
    else
      flash[:message] = 'Enter some content!'
      redirect to '/tweets/new'
    end
  end
end