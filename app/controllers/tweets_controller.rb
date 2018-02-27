class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect '/'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :"tweets/create_tweet"
    else
      redirect '/'
    end
  end

  post '/tweets/new' do
    if params[:tweet] == ""
      redirect to '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:tweet],user_id: session[:user_id])
      redirect to '/tweets'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect '/'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :"tweets/edit_tweet"
    else
      redirect '/'
    end

  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect to '/tweets'
  end

  delete '/tweets/:id/delete' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      @tweet.delete
      redirect to 'tweets'
    else
      redirect '/'
    end
  end

end
