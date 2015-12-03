require 'rubygems'
require 'bundler'

$rbot_root = File.expand_path(File.dirname(__FILE__))
load './config.rb'

namespace :db do
  task :migrate do
    sh "sequel -m db/migrations #{ENV['DB_URI']}"
  end
end