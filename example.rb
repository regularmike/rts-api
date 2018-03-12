require './lib/rts_api.rb'
require 'logger'

logger = Logger.new STDOUT
logger.level = Logger::INFO
rts = RtsApi::Client.new(logger: logger) 
#rts = RtsApi::Client.new
rest = rts.performance_schedule(show_aval_tickets: true, show_sales: true,
                              show_sale_links: true) do |res|
  puts res.tickets
end

