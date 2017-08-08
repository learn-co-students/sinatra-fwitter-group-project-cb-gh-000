class ApplicationController < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  configure do
    enable :sessions
    set :session_secret, 'twitter_secret'

    set :public_folder, 'public'
    set :views, 'app/views'
  end

  use Rack::Flash

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user' unless logged_in?
  end

  post '/signup' do
    new_user = User.new(params[:new_user])

    if new_user.save
      session[:user_id] = new_user.id
      redirect to '/tweets'
    else
      flash[:message] = 'All fields are required!'
      redirect to '/signup'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end
  end
end