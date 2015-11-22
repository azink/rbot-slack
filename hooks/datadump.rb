class Datadump < SlackRubyBot::Commands::Base
  match(/^!datadump/i) do |client, data, match|
    client.message text: "Client: #{client.inspect}, Data: #{data.inspect}, Match: #{match.inspect}", channel: data.channel
  end
end