class TweetsController < ApplicationController

  get '/tweets' do
    "Tweets with id #{logged_in?}"
  end
end