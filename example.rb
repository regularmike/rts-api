require './lib/rts_api.rb'
require 'logger'

logger = Logger.new STDOUT
logger.level = Logger::INFO
rts = RtsApi::Client.new(logger: logger) 
#rts = RtsApi::Client.new
puts rts.performance_schedule(show_available_tickets: true, show_sales: true,
                              show_sale_links: true).link_prefix
