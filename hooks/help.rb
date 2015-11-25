class RBHelp < SlackRubyBot::Commands::Base
  match(/^!help/i) do |client, data, match|
    client.message text: "See https://github.com/azink/rbot-slack for more information on available hooks.  Ask Gand for push privileges.", channel: data.channel
  end
end