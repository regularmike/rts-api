# Main module for RTS API wrapper gem
module RtsApi
  require_relative 'rts_api/client.rb'
  require_relative 'rts_api/request_packet_formatter.rb'
  require_relative 'rts_api/xml_reader.rb'
  require_relative 'rts_api/response.rb'
  require_relative 'rts_api/response_factory.rb'

  # Response classes corresponding to each available command
  require_relative 'rts_api/performance_schedule.rb'
  require_relative 'rts_api/gift_loyalty_card_information.rb'
  require_relative 'rts_api/gift_card_purchase.rb'
end
