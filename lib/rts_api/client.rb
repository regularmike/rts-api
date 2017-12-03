require 'net/http'
require 'nokogiri'

module RtsApi
  
  class Client

    # it's unclear what <Version>1</Version> refers to
    # but it's the first child node in every request packet
    VERSION = 1

    def initialize(options = {})
      @url             = options[:url]                      || 'https://5.formovietickets.com:2235/Data.ASP'
      @username        = options[:username]                 || 'test'
      @password        = options[:password]                 || 'test'           
      @response_format = options[:response_format]          || :nokogiri
      @formatter       = options[:request_packet_formatter] || RequestPacketFormatter.new(VERSION)
    end

    # assume missing methods correspond to API "commands" 
    # and methods of the packet formatter
    #
    def method_missing(command, *args, &block)
      begin
        request_packet = @formatter.send(command, *args)
      rescue
        raise NoMethodError, "The '#{command}' API command does not exist or is not supported by this library."
      end
      
      get_response(request_packet, command)   
    end

    def get_response(request_packet, command)
      uri = URI(@url)
      req = Net::HTTP::Post.new(uri)
      req.basic_auth @username, @password
      req.content_type = 'text/xml'
      req.body = request_packet.to_s
      res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
        http.request(req)
      end

      RtsApi::ResponseFactory.create(command, res)
    end

  end

end
