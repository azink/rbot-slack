class DebugDatadump < SlackRubyBot::Commands::Base
  match(/^!debug restart/i) do |client, data, match|
    client.message text: "Attempting to restart rb... :stuck_out_tongue_closed_eyes: :gun:", channel: data.channel

    pid = Process.fork do
      `cd #{File.dirname(__FILE__)}/.. && ruby rbot.rb restart`
    end
  end
end