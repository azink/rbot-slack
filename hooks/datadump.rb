class Datadump < SlackRubyBot::Commands::Base
  match(/^!datadump/i) do |client, data, match|
    client.message text: "Data: #{data.inspect}", channel: data.channel
  end
end