module RtsApi
  # Response subclass for working with an RTS
  # gift card/loyalty card information response packet
  class GiftLoyaltyCardInformation < Response
    RegisteredInfo = Struct.new(:first_name, :last_name, :address1, :address2, :city, :state, :postal)

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
        text_node('FirstName', info),
        text_node('LastName', info),
        text_node('Address1', info),
        text_node('Address2', info),
        text_node('City', info),
        text_node('State', info),
        text_node('Postal', info)
      )
    end
  end
end
