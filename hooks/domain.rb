class Domain < SlackRubyBot::Commands::Base
  match(/^!domain($|\s(?<args>.+$))/i) do |client, data, match|
    require 'whois'
    if match[:args].nil?
      out = "!domain <string>.  Look up a domain."
    else    
      args = match[:args][/\|(.+\..+)>/,1]
      r = Whois::Client.new.lookup(args)
      if r.available?
        out = "#{args} available"
      elsif r.to_s =~ /expir(?:es|ation)(?:\s+on)?(?:\s+date)?(?:[^:\r\n]*:)?\s*(.+)/i
        out = "#{args} expires #{$1.strip}"
      else
        out = "Parse error in whois response for #{args}"
      end
    end
    client.message text: out, channel: data.channel
  end
end
