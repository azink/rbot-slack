class Update < SlackRubyBot::Commands::Base
  match(/^!update$/i) do |client, data, match|
    out = `cd #{$rbot_root} && git pull`
    client.message text: out, channel: data.channel
    client.message text: "Reloading hooks...", channel: data.channel
    Dir["#{$rbot_root}/hooks/*.rb"].each {|f| load f}
  end
end 
