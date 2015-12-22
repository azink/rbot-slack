class UrbanDictionary < SlackRubyBot::Commands::Base
  match(/^!ud($|\s(?<args>.+$))/i) do |client, data, match|
    require 'nokogiri'
    require 'numbers_in_words'
    doc = Nokogiri::HTML(open("http://www.urbandictionary.com/define.php?term=#{match[:args]}"))
    word = doc.at_css('a.word').text
    meanings = doc.css("div.meaning").map {|x| x.text.strip}[0..2]

    client.message text: "Top Urban Dictionary definitions for: *#{word}*", channel: data.channel
    meanings.each_with_index { |x, i| client.message text: ":#{NumbersInWords.in_words(i+1)}: #{x}", channel: data.channel }
  end
end
