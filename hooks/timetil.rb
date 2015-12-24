class Timetil < SlackRubyBot::Commands::Base
  match(/^!timetil($|\s(?<args>.+$))/i) do |client, data, match|
    require 'chronic'
    require 'chronic_duration'
    require 'time_difference'

    start_time = Time.now

    # subs
    end_time = Chronic.parse(match[:args])
    end_time = "12/25" if match[:args] =~ /christmas/i
    end_time = start_time if match[:args] =~ /beer/i

    if end_time.nil?
      # cannot parse time
      out = "Time until when?"
    else
      diff_time = TimeDifference.between(start_time, end_time).in_seconds
      if start_time > end_time
        out = "Already past"
      else
        out = ChronicDuration.output(diff_time, :format => :short, :keep_zero => true).gsub(/\.\d+s/, "s")
      end
    end
    client.message text: out, channel: data.channel
  end
end
