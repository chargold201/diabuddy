class EntriesController < ApplicationController

    get '/entries' do
        authenticate
        @entries = Entry.where(user_id: current_user.id).sort_by{|entry| entry.created_at}.reverse
        erb :'/entries/index'
    end

    get '/entries/new' do
        if logged_in?
            erb :'/entries/new'
        else
            erb :unauthorized
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
                erb :unauthorized
            end
        else
            erb :unauthorized
        end
    end

    delete '/entries/:id' do
        Entry.delete(params[:id])
        redirect to '/entries'
    end

    get '/entries/:id/edit' do
        if logged_in?
            @entry = Entry.find(params[:id])
            if @entry.user == current_user
                erb :'/entries/edit'
            else
                redirect to '/entries'
            end
        else
            erb :unauthorized
        end
    end

    patch '/entries/:id' do
        @entry = Entry.find(params[:id])
        @entry.update(glucose: params[:glucose], carbs: params[:carbs], insulin: params[:insulin], note: params[:note])
        redirect to "/entries/#{params[:id]}"
    end
end