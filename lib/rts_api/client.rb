require 'net/http'
require 'nokogiri'

module RtsApi
  
  class Client

    RTS_VERSION = 1

    def initialize(options = {})
      @url = options[:url] || 'https://5.formovietickets.com:2235/Data.ASP'
      @username = options[:username] || 'test'
      @password = options[:password] || 'test'     
      @formatter = RequestPacketFormatter.new(RTS_VERSION)
    end

    def method_missing(m, *args, &block)
      begin
        xml_doc = @formatter.send(m, *args)
        get_response(xml_doc)
      rescue
        raise NoMethodError, "The '#{m}' API command does not exist or is not supported by this library."
      end
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

end
