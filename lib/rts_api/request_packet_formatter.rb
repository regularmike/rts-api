require 'nokogiri'

module RtsApi
  # Handles the formatting of request packets for the various API commands
  class RequestPacketFormatter
    def initialize(version)
      @version = version
    end

    def performance_schedule(
      show_aval_tickets: false,
      show_sales: false,
      show_sale_links: false
    )
      xml_doc = create_request_stub('ShowTimeXml')
      req = xml_doc.at('Request')
      req.add_child('<ShowAvalTickets>1</ShowAvalTickets>') if show_aval_tickets
      req.add_child('<ShowSales>1</ShowSales>') if show_sales
      req.add_child('<ShowSaleLinks>1</ShowSaleLinks>') if show_sale_links
      xml_doc
    end

    def gift_card_loyalty_card_information(card_number)
      xml_doc = create_request_stub('GiftInformation')
      req = xml_doc.at('Request')
      data = Nokogiri::XML::Builder.new do |xml|
        xml.Data {
          xml.Packet {
            xml.GiftCards {
              xml.GiftCard card_number
            }
          }
        }
      end.doc.root.to_s
      req.add_child(data)
      xml_doc
    end

    def gift_card_purchase(amount:, card:)
      xml_doc = create_request_stub('Buy')
      req = xml_doc.at('Request')
      data = Nokogiri::XML::Builder.new do |xml|
        xml.Data {
          xml.Packet {
            xml.PurchaseGifts {
              xml.PurchaseGift {
                xml.Amount amount
              }
            }
            xml.Payments
          }
        }
      end.doc.root
      data.at('Payments').add_child(card.to_payment_xml_doc(amount))
      req.add_child(data.to_xml)
      xml_doc
    end

    private

    def create_request_stub(command)
      Nokogiri::XML::Builder.new do |xml|
        xml.Request do 
          xml.Version @version
          xml.Command command
        end 
      end.doc
    end
  end
end
