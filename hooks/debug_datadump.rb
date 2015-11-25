class DebugDatadump < SlackRubyBot::Commands::Base
  match(/^!debug datadump/i) do |client, data, match|
    client.message text: "Data: #{data.inspect}", channel: data.channel
    client.message text: "User: #{data['user']['name']}", channel: data.channel
  end
end