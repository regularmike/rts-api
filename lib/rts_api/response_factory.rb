module RtsApi
  # Creates a response subclass based on the command
  class ResponseFactory
    def self.create(command, res)
      case command
      when :performance_schedule
        then PerformanceSchedule.new(res)
      when :gift_loyalty_card_information
        then GiftLoyaltyCardInformation.new(res)
      when :gift_card_purchase
        then GiftCardPurchase.new(res)
      else Response.new(res)
      end
    end
  end
end
