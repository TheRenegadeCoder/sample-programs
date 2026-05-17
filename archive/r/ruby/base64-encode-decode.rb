# frozen_string_literal: true

require "base64"

USAGE = "Usage: please provide a mode and a string to encode/decode"

mode, input = ARGV

abort(USAGE) if mode.nil? || input.nil? || input.strip.empty?

case mode
when "encode"
  puts Base64.strict_encode64(input)

when "decode"
  begin
    puts Base64.strict_decode64(input)
  rescue
    abort(USAGE)
  end

else
  abort(USAGE)
end
