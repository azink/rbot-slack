# Whatis and Remember

class Whatis < SlackRubyBot::Commands::Base
  # whatis: lookup
  match(/^!whatis\s(?<args>.+$)/i) do |client, data, match|
    rows = DB[:whatis].where(Sequel.like(:thekey, "%#{match[:args]}%")).sort_by {|row| row[:thekey].length}[0...10]
    if rows.length > 0
      res = rows.shift
      lines = res[:value].split("{BR}")
      client.message text: "#{res[:nick].strip} taught me that #{res[:thekey]} == #{lines.shift}", channel: data.channel
      lines.each { |line| client.message text: line, channel: data.channel }
      if rows.length > 0
        rows = rows[0..4] + [{:thekey => '...'}] if rows.length > 9
        client.message text: "(also: #{rows.map {|a| a[:thekey] }.join(', ')})", channel: data.channel
      end
    else
      client.message text: "#{match[:args]} not found", channel: data.channel
    end
  end

  # remember: store value
  match(/^!remember\s(?<key>[^=]+)==(?<value>.+$)/i) do |client, data, match|
    row = DB[:whatis].where(:thekey => match[:key].strip).first
    if row
      client.message text: "#{row[:nick]} already taught me that #{row[:thekey]} == #{row[:value]}", channel: data.channel
    else
      DB[:whatis].insert(:thekey => match[:key].strip, :value => match[:value].strip, :nick => find_user(client, data.user)['name'])
      client.message text: "okay, #{match[:key]} == #{match[:value]}", channel: data.channel
    end
  end

  # forget: remove value
  match(/^!forget\s(?<args>.+$)/i) do |client, data, match|
    bykey = DB[:whatis].filter(:thekey => match[:args].strip)
    row = bykey.first
    if row
      bykey.delete
      client.message text: "forgot that #{row[:nick]} taught me #{row[:thekey]} == #{row[:value]}", channel: data.channel
    else
      client.message text: "don't know about #{match[:args]}", channel: data.channel
    end
  end
end
