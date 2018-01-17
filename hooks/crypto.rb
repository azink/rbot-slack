# Crypto currency 
class CryptoCurrency < SlackRubyBot::Commands::Base
  match(/^!(crypto|btc)($|\s(?<args>.+$))/i) do |client, data, match|
    require 'json'

    def self.format_currency(num)
      sprintf('%.2f',num).gsub('.00','').reverse.scan(/(\d*\.\d{1,3}|\d{1,3})/).join(',').reverse
    end

    # default to BTC
    symbol = match[:args].nil? ? "BTC" : match[:args].upcase
    info = JSON.parse(open("https://api.coinmarketcap.com/v1/ticker/").read)
    item = info.find {|x| x['symbol'] == symbol}

    if item.nil?
      out = "Error parsing quote for #{match[:args]}. Check the symbol and try again."
    else
      out = "#{item['name']} (#{item['symbol']}) - Price USD: $#{format_currency(item['price_usd'])} - Change Rate: #{item['percent_change_1h']}% 1h, #{item['percent_change_24h']}% 24h, #{item['percent_change_7d']}% 7d"
    end
    client.message text: out, channel: data.channel
  end
end

