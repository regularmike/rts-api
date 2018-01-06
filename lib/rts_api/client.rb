require 'net/http'
require 'nokogiri'
require 'logger'

module RtsApi
  
  class Client

    # it's unclear what <Version>1</Version> refers to
    # but it's the first child node in every request packet
    VERSION = 1

    def initialize(
      url: 'https://5.formovietickets.com:2235/Data.ASP',
      username: 'test',
      password: 'test',
      formatter: RequestPacketFormatter.new(VERSION),
      logger: nil)

      @url = url
      @username = username
      @password = password
      @formatter = formatter       
      @logger = logger
      unless @logger
        @logger = ::Logger.new STDOUT
        @logger.level = ::Logger::WARN
      end
    end

    # assume missing methods correspond to API "commands" 
    # and methods of the packet formatter
    #
    def method_missing(command, *args, &block)
      begin
        request_packet = @formatter.send(command, *args)
      rescue NoMethodError
        # log an error if the missing method was an attempted API command
        unless @formatter.respond_to?(command)
          @log.error("The '#{command}' API command does not exist or is not supported by this library.") 
        end
        raise  
      end
      
      @logger.info("Preparing to send the following request packet:\n #{request_packet}")
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

      ResponseFactory.create(command, res)
    end

  end

end
