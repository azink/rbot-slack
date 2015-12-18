class SimpleCommands < SlackRubyBot::Commands::Base
  match(/^!help$/i) do |client, data, match|
    client.message text: "See https://github.com/azink/rbot-slack for more information on available hooks.  Ask Gand for push privileges.", channel: data.channel
  end

  match(/^!ping$/i) do |client, data, match|
    client.message text: "pong", channel: data.channel
  end

  match(/^!next\s/i) do |client, data, match|
    client.message text: "This isn't 1999, you graybeard.  Use direct messages or @username for !next.", channel: data.channel
  end

  match(/^!beer/i) do |client, data, match|
    client.message text: ":beers:", channel: data.channel
  end
end 
