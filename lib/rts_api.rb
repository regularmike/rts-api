require 'net/http'
require 'nokogiri'

class RtsApi
  
  def initialize(options = {})
    @url = options[:url] || 'https://5.formovietickets.com:2235/Data.ASP'
    @username = options[:username] || 'test'
    @password = options[:password] || 'test'
  end


  def performance_schedule(show_available_tickets = false, show_sales = false, show_sale_links = false)
    xml_doc = create_request_xml('ShowTimeXml')
    req = xml_doc.at('Request')
    req.add_child('<ShowAvalTickets>1</ShowAvalTickets>') if show_available_tickets
    req.add_child('<ShowSales>1</ShowSales>') if show_sales
    req.add_child('<ShowSaleLinks>1</ShowSaleLinks>') if show_sale_links
    puts get_response(xml_doc)
  end

  private

    def create_request_xml(command)
      Nokogiri::XML("<Request><Version>1</Version><Command>#{command}</Command></Request>")      
    end   

    def get_response(xml_doc)
      uri = URI(@url)
      req = Net::HTTP::Post.new(uri)
      req.basic_auth @username, @password
      req.content_type = 'text/xml'
      req.body = xml_doc.to_s
      res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
        http.request(req)
      end
      puts res.body
    end
end

rts = RtsApi.new
rts.performance_schedule(true, true, true)
