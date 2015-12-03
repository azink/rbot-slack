require 'rubygems'
require 'bundler'

load './config.rb'

namespace :db do
  task :migrate do
    sh "sequel -m db/migrations #{ENV['DB_URI']}"
  end
end