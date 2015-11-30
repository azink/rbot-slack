require 'daemons'
require 'slack-ruby-bot'
require './lib/patches'
require './config'

module Rbot
  class App < SlackRubyBot::App
  end

  Dir['./hooks/*.rb'].each {|f| load f}
end

Daemons.run_proc('rbot-slack', {:log_output => true, :backtrace => true, :dir => 'log'}) do 
  Rbot::App.instance.run
end