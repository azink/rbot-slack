# Stocks
class Stock < SlackRubyBot::Commands::Base
  match(/^!stock($|\s(?<args>.+$))/i) do |client, data, match|
    require 'json'
    info = JSON.parse(open("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{match[:args]}&interval=1min&apikey=#{ENV['ALPHA_KEY']}").read)
    if (info['Meta Data'])
      s_name = info['Meta Data']['2. Symbol'].upcase
      y_close = info['Time Series (Daily)'][1][1]['1. open'].to_f
      s_close = info['Time Series (Daily)'].first[1]['4. close'].to_f
      s_high = info['Time Series (Daily)'].first[1]['2. high'].to_f
      s_low = info['Time Series (Daily)'].first[1]['3. low'].to_f
      s_change = (s_close - y_close).round(2)
      s_pct = ((s_change / y_close) * 100).round(2)
      s_change = "+#{s_change}" if s_change > 0
      s_pct = "+#{s_pct}" if s_pct > 0

      out = "#{s_name} - Last: #{s_close}, (#{s_change}, #{s_pct}%); high: #{s_high}, low: #{s_low}"
    else
      out = "Error parsing quote for #{match[:args]}. Check the symbol and try again."
    end
    client.message text: out, channel: data.channel
  end
end
