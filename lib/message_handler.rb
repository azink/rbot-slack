# Applies to all messages
class MessageHandler < SlackRubyBot::Commands::Base
  match_all do |client, data, match|
    user = find_user(client, data.user)
    username = user.nil? ? data.user : user['name']
    unless username.nil?
      # update last table for !seen
      DB['INSERT OR REPLACE INTO last VALUES(?, ?, ?, ?);', username, data.channel, data.text, Time.now.to_i].all

      # write to log
      dir = "#{$rbot_root}/log/#{data.channel}"
      t = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
      log = "#{dir}/#{Time.now.utc.strftime('%Y-%m-%d')}-#{data.channel}.log"
      Dir.mkdir(dir) unless File.directory?(dir)
      File.open(log, "a+") do |f|
        f.puts("#{t} <#{username}> #{data.text}")
      end
    end
  end
end

