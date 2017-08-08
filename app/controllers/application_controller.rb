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

end