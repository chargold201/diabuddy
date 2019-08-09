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
            redirect to '/login'
        end
    end

    post '/entries' do
        if params[:glucose] == "" && params[:carbs] == "" && params[:insulin] == "" && params[:note] == ""
            redirect 'entries/new'
        else
            Entry.create(glucose: params[:glucose], carbs: params[:carbs], insulin: params[:insulin], note: params[:note], user_id: current_user.id)
            redirect to '/entries'
        end
    end

    get '/entries/:id' do
        if logged_in?
            @entry = Entry.find(params[:id])
            if @entry.user == current_user
                erb :'/entries/show'
            else
                redirect to '/entries'
            end
        else
            redirect to '/'
        end
    end

    delete '/entries/:id' do
        @entry = Entry.find(params[:id])
        if @entry.user == current_user
            Entry.delete(params[:id])
            redirect to '/entries'
        else
            redirect to "/entries/#{params[:id]}"
        end
    end
end