require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
  end

  get "/" do
    erb :index
  end

  not_found do 
    status 404
    erb :not_found
  end

  helpers do
    def current_user
        @current_user ||= User.find(session[:user_id])
    end

    def logged_in?
        !!session[:user_id]
    end
  end
end
