class SessionsController < ApplicationController

    get '/login' do
        if logged_in?
            redirect to '/entries'
        else
            erb :'/sessions/login'
        end
    end

    post '/login' do
        user = User.find_by(email: params[:email])
        if !user
            redirect to '/signup'
        elsif user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/entries'
        else
            redirect to '/login'
        end
    end

    get '/signup' do
        if logged_in?
            redirect to '/entries'
        else
            erb :'/sessions/signup'
        end
    end

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
        session.clear if logged_in?
        redirect to '/'
    end

    helpers do
        def current_user
            User.find(session[:user_id])
        end
    
        def logged_in?
            !!session[:user_id]
        end
    end
end