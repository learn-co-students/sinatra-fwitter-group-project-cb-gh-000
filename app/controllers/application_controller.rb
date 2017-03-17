require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "Fwitter"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/create'
    end
  end

  post '/signup' do
    user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if user.save
      session[:id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params["username"])
    if user && user.authenticate(params["password"])
      session[:id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user
      erb :'users/tweets'
    else
      redirect '/'
    end
  end

  get '/tweets' do
    if logged_in?(session)
      @user = current_user(session)
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?(session)
      erb :'tweets/create'
    else
      redirect '/login'
    end
  end

  put '/tweets' do
    if logged_in?(session)
      tweet = Tweet.new(content: params["content"], user_id: session[:id])
      if tweet.save
        redirect '/tweets'
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id' do
    if logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet
        erb :'tweets/show'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user_id == session[:id]
        erb :'tweets/edit'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user_id == session[:id]
        if @tweet.update(content: params["content"])
          redirect "/tweets/#{@tweet.id}"
        else
          redirect "/tweets/#{@tweet.id}/edit"
        end
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/delete' do
    if logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user_id == session[:id]
        if @tweet.delete
          redirect "/tweets"
        else
          redirect "/tweets/#{@tweet.id}"
        end
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  helpers do
    def current_user(session)
      User.find(session[:id])
    end

    def logged_in?(session)
      !!session[:id]
    end
  end

end