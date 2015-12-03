module SlackRubyBot
  module Commands
    class Base
      # disable gif responses
      def self.get_gif_and_send(options = {})
        options = options.dup
        client = options.delete(:client)
        text = options.delete(:text)
        send_client_message(client, { text: text }.merge(options))
      end

      # add ability to find a user
      def self.find_user(client, id)
        client.users.find {|f| f['id'] == id}
      end

      # match all messages
      def self.match_all(&block)
        match Regexp.new(".*", Regexp::IGNORECASE), &block
      end
    end
  end
end
