module SlackRubyBot
  module Commands
    class Base
      def self.get_gif_and_send(options = {})
        options = options.dup
        client = options.delete(:client)
        text = options.delete(:text)
        send_client_message(client, { text: text }.merge(options))
      end

      def self.find_user(client, id)
        client.users.find {|f| f['id'] == id}
      end
    end
  end
end