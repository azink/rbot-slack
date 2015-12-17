#!/usr/bin/env ruby

$rbot_root = File.expand_path(File.dirname(__FILE__))
require 'daemons'
require 'slack-ruby-bot'
require 'open-uri'
require './config'

# load initializers
Dir["#{$rbot_root}/initializers/*.rb"].each {|f| require f}

# Make sure log/pid dir exists
Dir.mkdir("#{$rbot_root}/log") unless File.directory?("#{$rbot_root}/log")

module Rbot
  class App < SlackRubyBot::App
  end

  # configuration
  SlackRubyBot.configure do |config|
    config.send_gifs = false
  end


  # Load hooks
  Dir["#{$rbot_root}/hooks/*.rb"].each {|f| load f}
end

Daemons.run_proc('rbot-slack', {:log_output => true, :backtrace => true, :dir => 'log'}) do 
  Rbot::App.instance.run
end