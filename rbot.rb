require 'slack-ruby-bot'
require './patches.rb'

module Rbot
  class App < SlackRubyBot::App
  end

  Dir["./hooks/*.rb"].each {|f| require f}
end

Rbot::App.instance.run