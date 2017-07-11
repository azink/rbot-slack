# log messages and update last table, applies to all messages
# extend message class

module SlackRubyBot
  module Hooks
    module Message
      extend SlackRubyBot::Hooks::Base
      alias_method :sb_message, :message

      def message(client, data)
        data = Hashie::Mash.new(data)
        user = SlackRubyBot::Commands::Base.find_user(client, data.user)
        puts user.inspect
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
        # call original message
        sb_message(client, data)
      end
    end
  end
end