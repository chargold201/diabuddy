class EntriesController < ApplicationController

    get '/entries' do
        @entries = Entry.where(user_id: current_user.id)
        erb :'/entries/index'
    end
end