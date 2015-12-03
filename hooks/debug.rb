# debugging commands

class DebugDatadump < SlackRubyBot::Commands::Base
  match(/^!debug datadump/i) do |client, data, match|
    client.message text: "Data: #{data.inspect}", channel: data.channel
    client.message text: "User: #{data['user']['name']}", channel: data.channel
  end
end

class DebugDatadump < SlackRubyBot::Commands::Base
  match(/^!debug restart/i) do |client, data, match|
    client.message text: "Attempting to restart rb... :stuck_out_tongue_closed_eyes: :gun:", channel: data.channel

    pid = Process.fork do
      `cd #{$rbot_root} && ruby rbot.rb restart`
    end
  end
end

class DebugUserinfo < SlackRubyBot::Commands::Base
  match(/^!debug userinfo($|\s(?<args>.+$))/i) do |client, data, match|
    client.message text: "#{client.users.find {|f| f['id'] == match[:args]}}", channel: data.channel
  end
end
