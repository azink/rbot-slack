require 'daemons'

Daemons.run('./bin/rbot-slack.rb', {:log_output => true, :backtrace => true, :dir => '../log'})