class SessionsController < ApplicationController

    get '/login' do
        erb :'/sessions/login'
    end

    post '/login' do
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/entries'
        end
    end

    get '/signup' do
        erb :'/sessions/signup'
    end

    post '/signup' do
        
    end
end