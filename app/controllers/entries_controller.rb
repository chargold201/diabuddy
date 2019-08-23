class EntriesController < ApplicationController

    get '/entries' do
        authenticate
        @entries = Entry.where(user_id: current_user.id).sort_by{|entry| entry.created_at}.reverse
        erb :'/entries/index'
    end

    get '/entries/new' do
        authenticate
        @failed = false
        erb :'/entries/new'
    end

    post '/entries' do
        authenticate
        if params[:glucose] == "" && params[:carbs] == "" && params[:insulin] == "" && params[:note] == ""
            @failed = true
            erb :'entries/new'
        else
            Entry.create(glucose: params[:glucose], carbs: params[:carbs], insulin: params[:insulin], note: params[:note], user_id: current_user.id)
            redirect to '/entries'
        end
    end

    get '/entries/:id' do
        authenticate
        @entry = Entry.find(params[:id])
        authenticate_user(@entry)
        erb :'/entries/show'
    end

    delete '/entries/:id' do
      authenticate
      @entry = Entry.find(params[:id])
      authenticate_user(@entry)
      @entry.destroy
      redirect to '/entries'
    end

    get '/entries/:id/edit' do
      authenticate
      @entry = Entry.find(params[:id])
      authenticate_user(@entry)
      erb :'/entries/edit' 
    end

    patch '/entries/:id' do
        authenticate
        @entry = Entry.find(params[:id])
        authenticate_user(@entry)
        if params[:glucose] == "" && params[:carbs] == "" && params[:insulin] == "" && params[:note] == ""
          @failed = true
          erb :'entries/edit'
        else
          @entry.update(glucose: params[:glucose], carbs: params[:carbs], insulin: params[:insulin], note: params[:note])
          redirect to "/entries/#{params[:id]}"
        end
    end
end