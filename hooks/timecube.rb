# Timecube
class Timecube < SlackRubyBot::Commands::Base
  match(/^!timecube$/i) do |client, data, match|
    body = open("http://timecube.com").read
    body.gsub!(/[\r\n]+/, " ")
    body.gsub!(/<\/?\w+((\s+\w+(\s*=\s*(?:".*?"|'.*?'|[^'">\s]+))?)+\s*|\s*)\/?>/, "")
    body.gsub!("&nbsp;", "")
    body.gsub!("&quot;", "")
    body.gsub!("**", "")
    line = body.split(". ").sample
    client.message text: line, channel: data.channel
  end
end
