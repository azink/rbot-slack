require 'slack-ruby-bot'

module Rbot
  class App < SlackRubyBot::App
  end

  Dir["./hooks/*.rb"].each {|f| require f}
end

Rbot::App.instance.run