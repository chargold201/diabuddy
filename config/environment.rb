ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

if ENV['SINATRA_ENV'] == 'development'
  require_relative '../secrets.rb'
end

require_relative '../constants'
require './app/controllers/application_controller'
require_all 'app'
