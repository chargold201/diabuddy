class EntriesController < ApplicationController

    get '/entries' do
        if logged_in?
            @entries = Entry.where(user_id: current_user.id)
            erb :'/entries/index'
        else
            redirect to '/'
        end
    end

    get '/entries/new' do
        if logged_in?
            erb :'/entries/new'
        else
            redirect '/login'
        end
    end

    post '/entries' do
        if params[:glucose] == "" && params[:carbs] == "" && params[:insulin] == "" && params[:note] == ""
            redirect 'entries/new'
        else
            Entry.create(glucose: params[:glucose], carbs: params[:carbs], insulin: params[:insulin], note: params[:note], user_id: current_user.id)
            redirect '/entries'
        end
    end
end