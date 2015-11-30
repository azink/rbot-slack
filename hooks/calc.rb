# simple calc
class Calc < SlackRubyBot::Commands::Base
  match(/^!calc($|\s(?<args>.+$))/i) do |client, data, match|
    out = `echo "#{match[:args]}" | bc -l 2>&1`
    client.message text: "bc result: #{out}", channel: data.channel
  end
end

