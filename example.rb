require './lib/rts_api.rb'
require 'logger'

logger = Logger.new STDOUT
logger.level = Logger::INFO
rts = RtsApi::Client.new(logger: logger) 
card = CreditCard.new(
  number: '5499990123456781',
  expiration: '0513',
  avs_street: '4 Main St',
  avs_postal: '30329',
  cid: '123',
  name_on_card: 'John Doe'
)
#rts = RtsApi::Client.new
res = rts.gift_card_purchase(amount: 25, card: card)

