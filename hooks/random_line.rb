class RandomLine < SlackRubyBot::Commands::Base
  # Reads random lines
  # Dynamically reads db/txt/*.txt on startup and generates hooks. Use symlinks for aliases.
  hooks = Dir["./db/txt/*.txt"].map {|f| f[/\/(\w+)\./, 1]}
  hooks.each do |hook|
    match(/^!#{hook}($|\s(?<args>.+$))/i) do |client, data, match|
      line = File.read("#{File.dirname(__FILE__)}/../db/txt/#{hook}.txt").split("\n").sample
      line.gsub!('$args', match[:args]) if match[:args]
      line.gsub!('$source', find_user(client, data.user)['name'])
      client.message text: line, channel: data.channel
    end
  end
end