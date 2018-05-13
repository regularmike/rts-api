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
      Nokogiri::XML::Builder.new do |xml|
        xml.Payment {
          xml.Type 'CreditCard'
          xml.Number @number
          xml.Expiration @expiration
          xml.AvsStreet @avs_street
          xml.AvsPostal @avs_postal
          xml.CID @cid
          xml.NameOnCard @name_on_card
          xml.ChargeAmount charge_amount
        }
      end.doc.root
    end
  end
end
