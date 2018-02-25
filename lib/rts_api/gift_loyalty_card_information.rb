module RtsApi
  # Response subclass for working with an RTS
  # gift card/loyalty card information response packet
  class GiftLoyaltyCardInformation < Response
    RegisteredInfo = Struct.new(:first_name, :last_name, :address1,
                                :address2, :city, :state, :postal)

    TicketCredit = Struct.new(:expiration, :start_date, :amount,
                              :title_restriction, :ticket_restriction)

    ItemCredit = Struct.new(:expiration, :start_date, :amount, :item)

    def debit_remain
      text_node('DebitRemain').to_f
    end

    def registered?
      text_node('Registered') == '1'
    end

    def registered_info
      return unless registered?
      info = packet.at('RegisteredInfo')
      RegisteredInfo.new(
        text_node('FirstName', info), text_node('LastName', info),
        text_node('Address1', info), text_node('Address2', info),
        text_node('City', info), text_node('State', info),
        text_node('Postal', info)
      )
    end

    def ticket_credits
      all_credits = node_set('CardCredits')
      all_credits.select { |credit| credit.name == 'TicketCredit' }
                 .map do |credit|
                   TicketCredit.new(text_node('Expiration', credit),
                                    text_node('StartDate', credit),
                                    text_node('Amount', credit).to_f,
                                    text_node('TitleRestriction', credit),
                                    text_node('TicketRestriction', credit))
                 end
    end

    def item_credits
      all_credits = node_set('CardCredits')
      all_credits.select { |credit| credit.name == 'ItemCredit' }
                 .map do |credit|
                   ItemCredit.new(text_node('Expiration', credit),
                                  text_node('StartDate', credit),
                                  text_node('Amount', credit).to_f,
                                  text_node('Item', credit))
                 end
    end
  end
end
