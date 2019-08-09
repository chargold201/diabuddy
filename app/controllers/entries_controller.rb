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
end