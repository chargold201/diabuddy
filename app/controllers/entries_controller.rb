class EntriesController < ApplicationController

    get '/entries' do
        authenticate
        @entries = Entry.where(user_id: current_user.id).sort_by{|entry| entry.created_at}.reverse
        erb :'/entries/index'
    end

    get '/entries/new' do
        authenticate
        erb :'/entries/new'
    end

    post '/entries' do
        authenticate
        if params[:glucose] == "" && params[:carbs] == "" && params[:insulin] == "" && params[:note] == ""
            redirect 'entries/new'
        else
            Entry.create(glucose: params[:glucose], carbs: params[:carbs], insulin: params[:insulin], note: params[:note], user_id: current_user.id)
            redirect to '/entries'
        end
    end

    get '/entries/:id' do
        authenticate
        @entry = Entry.find(params[:id])
        erb :'/entries/show' if @entry.user == current_user
        erb :unauthorized
    end

    delete '/entries/:id' do
      authenticate
      @entry = Entry.find(params[:id])
      if @entry.user == current_user
        @entry.destroy
        redirect to '/entries'
      else
        erb :unauthorized
      end
    end

    get '/entries/:id/edit' do
      authenticate
      @entry = Entry.find(params[:id])
      erb :'/entries/edit' if @entry.user == current_user
      erb :unauthorized
    end

    patch '/entries/:id' do
        authenticate
        @entry = Entry.find(params[:id])
        if @entry.user == current_user
          @entry.update(glucose: params[:glucose], carbs: params[:carbs], insulin: params[:insulin], note: params[:note])
          redirect to "/entries/#{params[:id]}"
        else
          erb :unauthorized
        end
    end
end