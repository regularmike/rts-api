require 'net/http'
require 'nokogiri'

module RtsApi
  
  class Client

    # not sure what <Version>1</Version> refers to but it's the first child node in every request packet
    VERSION = 1

    def initialize(options = {})
      @url             = options[:url]                      || 'https://5.formovietickets.com:2235/Data.ASP'
      @username        = options[:username]                 || 'test'
      @password        = options[:password]                 || 'test'           
      @response_format = options[:response_format]          || :nokogiri
      @formatter       = options[:request_packet_formatter] || RequestPacketFormatter.new(VERSION)
    end

    # assume missing methods can be found in the packet formatter,    
    # which is the only thing that cares what API command is sent
    def method_missing(m, *args, &block)
      begin
        xml_doc = @formatter.send(m, *args)
      rescue
        raise NoMethodError, "The '#{m}' API command does not exist or is not supported by this library."
      end
      
      get_response(xml_doc)      
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

      RtsApi::Response.new(res)
    end

  end

end
