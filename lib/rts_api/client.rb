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
        request = Request.new(request_packet, command)
      rescue NoMethodError
        # log an error if the missing method was an attempted API command
        unless @formatter.respond_to?(command)
          @log.error("The '#{command}' API command does not exist or is not supported by this library.") 
        end
        raise  
      end
      
      get_response_with_logging(request)
    end

    private

    def get_response(request)
      uri = URI(@url)
      req = Net::HTTP::Post.new(uri)
      req.basic_auth @username, @password
      req.content_type = 'text/xml'
      req.body = request.packet.to_s
      res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
        http.request(req)
      end

      ResponseFactory.create(request.command, res)
    end

    def get_response_with_logging(request)
      @logger.info("Sending #{request.command} command.")
      @logger.debug("Request packet:\n #{request.packet}")
      begin
        response = get_response(request) 
        @logger.info("Response HTTP status code: #{response.http_status_code}")
        @logger.debug("Response:\n #{response.packet}")
      rescue StandardError => error
        @logger.error(error)
      end
      response
    end
  end
end
