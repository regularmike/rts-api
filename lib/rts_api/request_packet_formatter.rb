require 'nokogiri'

module RtsApi
  class RequestPacketFormatter
    def initialize(version)
      @version = version
    end

    def performance_schedule(show_available_tickets: false, show_sales: false, show_sale_links: false)
      xml_doc = create_request_stub('ShowTimeXml')
      req = xml_doc.at('Request')
      req.add_child('<ShowAvalTickets>1</ShowAvalTickets>') if show_available_tickets
      req.add_child('<ShowSales>1</ShowSales>') if show_sales
      req.add_child('<ShowSaleLinks>1</ShowSaleLinks>') if show_sale_links
      xml_doc
    end

    private

    def create_request_stub(command)
      Nokogiri::XML("<Request><Version>#{@version}</Version><Command>#{command}</Command></Request>")      
    end   
  end
end
