#!/usr/bin/env ruby

$rbot_root = File.expand_path(File.dirname(__FILE__))
require 'daemons'
require 'slack-ruby-bot'
require 'open-uri'
require_relative 'config'
require_relative 'lib/patches'
require_relative 'lib/db'

module Rbot
  class App < SlackRubyBot::App
  end

  Dir['./hooks/*.rb'].each {|f| load f}
end

Daemons.run_proc('rbot-slack', {:log_output => true, :backtrace => true, :dir => 'log'}) do 
  Rbot::App.instance.run
end