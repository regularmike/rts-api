require './lib/rts_api.rb'
require 'logger'

logger = Logger.new STDOUT
logger.level = Logger::INFO
rts = RtsApi::Client.new(logger: logger) 
#rts = RtsApi::Client.new
puts rts.performance_schedule(true, true, true).link_prefix

