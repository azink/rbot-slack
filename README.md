# rbot-slack
A Rubybot implementation for Slack, customized for a cave of hats.

# Installation and running
1. Rename config.rb.sample to config.rb
2. Edit config.rb and replace config items
3. Launch with `bundle exec ruby rbot.rb start`

# Add hooks
Create a file in hooks.  Follow w.rb and ping.rb for exmaples.  For more details and examples see https://github.com/dblock/slack-ruby-bot

# Add text random line responders
Simply add .txt files to db/txt and random_line.rb will pick them up on launch

# Current list of useful hooks:
* !w - gets the weather from wunderground
* Random lines: See db/txt for active hooks
