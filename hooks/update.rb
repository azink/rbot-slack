class Update < SlackRubyBot::Commands::Base
  match(/^!update/i) do |client, data, match|
    out = `cd #{File.dirname(__FILE__)} && git pull`
    out += `cd #{File.dirname(__FILE__)} &&  ruby rbot.rb restart`
    client.message text: out, channel: data.channel
  end
end 
