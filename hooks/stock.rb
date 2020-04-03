# Stocks
class Stock < SlackRubyBot::Commands::Base
  match(/^!stock($|\s(?<args>.+$))/i) do |client, data, match|
    require 'json'
    require 'uri'
    require 'net/http'
    require 'openssl'

    url = URI("https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/get-quotes?region=US&lang=en&symbols=#{match[:args]}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'apidojo-yahoo-finance-v1.p.rapidapi.com'
    request["x-rapidapi-key"] = ENV['RAPID_API_KEY']

    response = http.request(request)
    info = JSON.parse(response.read_body)

    if (info['quoteResponse']['result'].empty?)
      out = "Error parsing quote for #{match[:args]}. Check the symbol and try again."
    else
      ticker = info['quoteResponse']['result'][0]

      s_symbol = ticker['symbol']
      s_name = ticker['shortName']
      s_exchange = ticker['fullExchangeName']
      s_price = ticker['regularMarketPrice']
      s_change = ticker['regularMarketChange'].round(2)
      s_change_pct = ticker['regularMarketChangePercent'].round(2)
      s_high = ticker['regularMarketDayHigh']
      s_low = ticker['regularMarketDayLow']
      if (ticker['postMarketPrice'])
        a_price = ticker['postMarketPrice']
        a_change = ticker['postMarketChange'].round(2)
        a_change_pct = ticker['postMarketChangePercent'].round(2)
        out = "#{s_name} (#{s_symbol}, #{s_exchange}) - Last close: #{s_price}, (#{s_change}, #{s_change_pct}%); high: #{s_high}, low: #{s_low}. Post-market: #{a_price}, (#{a_change}, #{a_change_pct}%)"
      else
        out = "#{s_name} (#{s_symbol}, #{s_exchange}) - Last close: #{s_price}, (#{s_change}, #{s_change_pct}%); high: #{s_high}, low: #{s_low}"
      end
    end
    client.message text: out, channel: data.channel
  end
end
