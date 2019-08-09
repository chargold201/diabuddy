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

    #check if email is already in use. If in use, redirect to signin.
    #if not in use, create new user with name, email, and password, log them in (new session), and redirect to entries.
    post '/signup' do
        user = User.find_by(email: params[:email])
        if user
            redirect to '/login'
        else
            user = User.create(name: params[:name], email: params[:email], password: params[:password])
            session[:user_id] = user.id
            redirect to '/entries'
        end
    end

    get '/logout' do
        session.clear
        redirect to '/'
    end
end