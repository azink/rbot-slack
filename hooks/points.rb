# Points

class Points < SlackRubyBot::Commands::Base
  # == with args: lookup item
  match(/^!(==|points)\s(?<args>.+$)/i) do |client, data, match|
    thing = DB[:points].filter(:thing => match[:args]).first
    points = thing ? thing[:points] : 0
    client.message text: "#{match[:args]} has #{points} points", channel: data.channel
  end

  # == without args: lookup top item
  match(/^!(==|points)$/i) do |client, data, match|
    top = DB[:points].order(Sequel.desc(:points)).limit(1).first
    best = top ? "#{top[:thing]} = #{top[:points]}" : ''
    bot = DB[:points].order(:points).limit(1).first
    worst = bot ? "#{bot[:thing]} = #{bot[:points]}" : ''
    client.message text: "<thing>; best: #{best}, worst: #{worst}", channel: data.channel
  end

  # ++: increment item
  match(/^!\+\+\s(?<args>.+$)/i) do |client, data, match|
    what = match[:args].downcase
    q = DB[:points].filter(:thing => what)
    row = q.first
    if row
      points = row[:points] + 1
      q.update(:points => points)
    else
      points = 1
      DB[:points].insert(:thing => what, :points => points)
    end
    client.message text: "#{what} has #{points} points", channel: data.channel
  end

  # ++: decrement item
  match(/^!--\s(?<args>.+$)/i) do |client, data, match|
    what = match[:args].downcase
    q = DB[:points].filter(:thing => what)
    row = q.first
    if row
      points = row[:points] - 1
      q.update(:points => points)
    else
      points = -1
      DB[:points].insert(:thing => what, :points => points)
    end
    client.message text: "#{what} has #{points} points", channel: data.channel
  end
end

