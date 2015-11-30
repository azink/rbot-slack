# Conversions using Wolfram Alpha
class Conv < SlackRubyBot::Commands::Base
  match(/^!conv($|\s(?<args>.+$))/i) do |client, data, match|
    require 'wolfram'

    Wolfram.appid = ENV['WOLFRAM_ID']
    r = Wolfram::HashPresenter.new(Wolfram.fetch(match[:args])).to_hash

    # deal with WA's various pod types
    if r[:pods]['Result'] and r[:pods]['Input interpretation'] then
      out = "Result: #{r[:pods]['Result'].first} (Interpreted input: #{r[:pods]['Input interpretation'].first})"
    elsif r[:pods]['Decimal approximation']
      out = "Result: #{r[:pods]['Decimal approximation'].first}"
    elsif r[:pods]['Exact result']
      out = "Result: #{r[:pods]['Exact result'].first}"
    elsif r[:pods]['Result']
      out = "Result: #{r[:pods]['Result'].first}"
    elsif r[:pods]['Results']
      out = "Result: #{r[:pods]['Results'].first}"
    else
      out = "THERE ARE FOUR LIGHTS"
    end

    client.message text: out, channel: data.channel
  end
end
