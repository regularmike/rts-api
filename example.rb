require './lib/rts_api.rb'

rts = RtsApi::Client.new
puts rts.performance_schedule(false, false, false).packet.to_s

