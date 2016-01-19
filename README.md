# rbot-slack
A Rubybot implementation for Slack, customized for a cave of hats.  Based on the Slack Ruby gem from https://github.com/dblock/slack-ruby-bot

## Installation and running
1. Rename config.rb.sample to config.rb
2. Edit config.rb and replace config items
3. Create the database with `rake db:migrate`
3. Launch with `ruby rbot.rb start`

## Add hooks
Create a file in hooks.  See the hooks dir for examples for examples.

## Add text random line responders
Simply add .txt files to db/txt and random_line.rb will pick them up on launch.  $args will be replaced with the arguments provided, and $source with the originating nick.

## Current list of (moderately) useful hooks:
* !bitcoin - Show current Bitcoin price (Alias: !btc)
* !calc - BC calculator
* !conv - Converter and math engine using Wolfram Alpha (Alias: !ask)
* !domain - Look up domain
* !flip - Flip text
* !hungry - Generate a delicious meal
* !points, !--, !++ - Add to or subrtract from the value of something
* !stock - Show stock information for a given symbol
* !timecube - You cannot comprehend this hook
* !timetil - Duration until something
* !ud - Get Urban Dictionary definitions
* !update - Update from git and reload hooks
* !w - gets the weather from wunderground.  For a default location, edit the "what I do" field in your profile
* !whatis/!remember/!forget - Remember something == something else
* Random lines: See db/txt for active hooks
