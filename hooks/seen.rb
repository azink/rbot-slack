# Seen - check last db for the last time spoken
class Seen < SlackRubyBot::Commands::Base
  def self.format_seen(row)
    minute_seconds = 60
    hour_seconds = 3600
    day_seconds = 86400
    week_seconds = 604800
    month_seconds = 2246400

    timediff = Time.now.to_i - row[:at]
    if timediff > week_seconds
      if timediff <= month_seconds
        formatstr = '%a %b %d'
      else
        formatstr = '%b %d %Y'
      end
      at = Time.at(row[:at]).strftime(formatstr)
    else
      if timediff <= minute_seconds
        at = "#{timediff}s"
      elsif timediff <= hour_seconds
        minutes = timediff / minute_seconds
        seconds = timediff - minutes * minute_seconds
        at = "#{minutes}m #{seconds}s"
      elsif timediff <= day_seconds
        hours = timediff / hour_seconds
        minutes = (timediff - hours * hour_seconds) / minute_seconds
        at = "#{hours}h #{minutes}m"
      else #timediff > DAY_SECONDS && timediff <= week_seconds
        days = timediff / day_seconds
        hours = (timediff - days * day_seconds) / hour_seconds
        at = "#{days}d #{hours}h"
      end
      at << ' ago'
    end
    "[#{at}] <#{row[:nick]}> #{row[:stmt]}"
  end

  match(/^!seen\s(?<args>.+$)/i) do |client, data, match|
    row = DB[:last].where(Sequel.like(:nick, "%#{match[:args].delete("@")}%")).first
    msg =
      if row
        format_seen(row)
      else
        "#{match[:args]} has not spoken since my log began"
      end
    client.message text: msg, channel: data.channel
  end
end

