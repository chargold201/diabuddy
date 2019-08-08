ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc "Open a Pry session in the terminal"
task :console do
    Pry.start
end