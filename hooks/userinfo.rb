class Userinfo < SlackRubyBot::Commands::Base
  match(/^!userinfo\s?(?<user>.*)/i) do |client, data, match|
    client.message text: "#{client.users.find {|f| f['id'] == match[:user]}}", channel: data.channel
  end
end
