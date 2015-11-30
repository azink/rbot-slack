require 'slack-ruby-bot'
require_relative '../lib/patches.rb'
require_relative '../config.rb'

module Rbot
  class App < SlackRubyBot::App
  end

  Dir["../hooks/*.rb"].each {|f| require f}
end

Rbot::App.instance.run
