# database connection

require 'sequel'
DB = Sequel.connect(ENV['DB_URI'])
