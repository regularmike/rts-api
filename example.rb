require './lib/rts_api.rb'

rts = RtsApi::Client.new
puts rts.performance_schedule(true, true, true).tickets[0].code

puts rts.performance_schedule(true, true, true).films[0].shows[0].ticket_type_codes
