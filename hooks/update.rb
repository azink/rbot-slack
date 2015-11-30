class Update < SlackRubyBot::Commands::Base
  match(/^!update/i) do |client, data, match|
    out = `cd #{File.dirname(__FILE__)}/.. && git pull`
    client.message text: out, channel: data.channel
    client.message text: "Reloading hooks...", channel: data.channel
    Dir["#{File.dirname(__FILE__)}/../hooks/*.rb"].each {|f| load f}
  end
end 
