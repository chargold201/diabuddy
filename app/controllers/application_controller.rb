require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    set :show_exceptions, false
  end

  get "/" do
    if logged_in?
      redirect '/entries'
    else
      erb :index, :layout => :layout_home
    end
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

    def authenticate
      raise AuthenticationError.new if !logged_in?
    end
  end

  error AuthenticationError do
    status 401
    erb :unauthorized
  end

  error ActiveRecord::RecordNotFound do
    status 404
    erb :not_found
  end
end
