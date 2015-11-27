# rbot-slack
A Rubybot implementation for Slack, customized for a cave of hats.

# Launch with:
```
export SLACK_API_TOKEN=...token...
export WUNDERGROUND_KEY=...example env...
bundle exec ruby rbot.rb
```

# Add hooks
Create a file in hooks.  Follow w.rb and ping.rb for exmaples.  For more details and examples see https://github.com/dblock/slack-ruby-bot

# Add text random line responders
Simply add .txt files to db/txt and random_line.rb will pick them up on launch

# Current list of useful hooks:
* !w - gets the weather from wunderground
* Random lines: See db/txt for active hooks
