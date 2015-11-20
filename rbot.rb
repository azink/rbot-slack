require 'slack-ruby-bot'

module Rbot
  class App < SlackRubyBot::App
  end

  Dir["./hooks/*.rb"].each {|f| require f}
end

SlackRubyBot.configure do |config|
  #config.aliases = Dir["./hooks/*.rb"].map {|f| "!" + f.split("/").last.gsub(".rb", "")} + "rb"
  config.aliases = ["!"]
end

Rbot::App.instance.run