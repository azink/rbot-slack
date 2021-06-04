class UrbanDictionary < SlackRubyBot::Commands::Base
  match(/^!ud($|\s(?<args>.+$))/i) do |client, data, match|
    require 'nokogiri'
    require 'numbers_in_words'
    doc = Nokogiri::HTML(open("https://www.urbandictionary.com/define.php?term=#{match[:args]}"))
    meanings = doc.css("div.meaning").map {|x| x.text.strip}.select {|x| x.length <= 1024}[0..3]

    # hax to remove word of the day
    arr.delete_at(1)

    if meanings[0] =~ /any definitions for/
      client.message text: "whoa there hep cat, your jive is too fresh for urban dictionary!", channel: data.channel  
    else
      word = doc.at_css('a.word').text

      client.message text: "Top Urban Dictionary definitions for: *#{word}*", channel: data.channel
      meanings.each_with_index { |x, i| client.message text: ":#{NumbersInWords.in_words(i+1)}: #{x}", channel: data.channel }
    end
  end
end
