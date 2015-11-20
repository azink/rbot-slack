class Ping < SlackRubyBot::Commands::Base
  match(/^!w (?<location>.*)/i) do |client, data, match|
    require 'wunderground'
    require 'date'

    w = Wunderground.new(ENV['WUNDERGROUND_KEY'])

    wx = w.conditions_for(match[:location])['current_observation']
    if wx then
      out = "#{wx['observation_location']['city']}, #{wx['display_location']['state']} #{wx['observation_time'][/, (.+$)/, 1]}: #{wx['weather']} #{wx['temp_f']}F, #{wx['relative_humidity']}, wind #{wx['wind_dir']} at #{wx['wind_mph']} mph"
      out += " gust #{wx['wind_gust_mph']}" if wx['wind_gust_mph'].to_f > 0
      out += ", precip today: #{wx['precip_today_in']}" if wx['precip_today_in'].to_f > 0
      client.message text: out, channel: data.channel
    else
      client.message text: "Error occurred or location not found", channel: data.channel
    end
  end
end

