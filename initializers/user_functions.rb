# add ability to find a user
module SlackRubyBot
  module Commands
    class Base 
      def self.find_user(client, id)
        return id if id.is_a? String
        client.users.find {|f| f['id'] == id}
      end
    end
  end
end
