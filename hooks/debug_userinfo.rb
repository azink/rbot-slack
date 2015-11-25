class DebugUserinfo < SlackRubyBot::Commands::Base
  match(/^!debug userinfo($|\s(?<args>.+$))/i) do |client, data, match|
    client.message text: "#{client.users.find {|f| f['id'] == match[:args]}}", channel: data.channel
  end
end
