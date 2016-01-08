# simple calc
class Calc < SlackRubyBot::Commands::Base
  match(/^!calc($|\s(?<args>.+$))/i) do |client, data, match|
    out = `echo "#{match[:args]}" | bc -l 2>&1`
    out = "Calc error. Try !conv <experssion> instead.  Error: #{out}" if out =~ /error/
    client.message text: out, channel: data.channel
  end
end

