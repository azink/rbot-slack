# Bitcoins
class Bitcoin < SlackRubyBot::Commands::Base
  match(/^!(btc|bitcoin)/i) do |client, data, match|
    require 'json'

    body = open("https://blockchain.info/ticker").read
    d = JSON.parse(body)['USD']

    out = "Blockchain (USD): 15m avg: #{d['15m']}, Last: #{d['last']}, Buy: #{d['buy']}, Sell: #{d['sell']}"
    client.message text: out, channel: data.channel
  end
end
