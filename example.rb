require './lib/rts_api.rb'

rts = RtsApi::Client.new
puts rts.performance_schedule
