class Ping < SlackRubyBot::Commands::Base
  match(/^!ping/i) do |client, data, match|
    client.message text: 'pong', channel: data.channel
  end
end