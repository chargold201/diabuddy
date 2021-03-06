class SessionsController < ApplicationController

    get '/login' do
        @failed = false
        if logged_in?
            redirect to '/entries'
        else
            erb :'/sessions/login'
        end
    end

    post '/login' do
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/entries'
        else
            @failed = true
            erb :'/sessions/login'
        end
    end

    get '/signup' do
        redirect to '/entries' if logged_in?
        erb :'/sessions/signup'
    end

    post '/signup' do
        @user = User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:confirm_password])
        if @user.errors.any?
            erb :'sessions/signup'
        else
            session[:user_id] = @user.id
            redirect to '/entries'
        end
    end

    get '/logout' do
        session.clear if logged_in?
        redirect to '/'
    end

end