require 'nokogiri'

module RtsApi
  # This class is for adding credit card payment xml documents
  # to any type of request
  class CreditCard
    def initialize(
      number:, expiration:, avs_street:, avs_postal:, cid:, name_on_card:
    )
      @number = number
      @expiration = expiration
      @avs_street = avs_street
      @avs_postal = avs_postal
      @cid = cid
      @name_on_card = name_on_card
    end

    def to_payment_xml_doc(charge_amount)
      Nokogiri::XML(
        '<Payment>' \
          '<Type>CreditCard</Type>' \
          "<Number>#{@number}</number>" \
          "<Expiration>#{@expiration}</Expiration>" \
          "<AvsStreet>#{@avs_street}</AvsStreet>" \
          "<AvsPostal>#{@avs_postal}</AvsPostal>" \
          "<CID>#{@cid}</CID>" \
          "<NameOnCard>#{@name_on_card}</NameOnCard>" \
          "<ChargeAmount>#{charge_amount}</ChargeAmount>" \
        '</Payment>'
      ).at('Payment').to_s
    end
  end
end
