require 'net/http'
require 'nokogiri'
require 'logger'

module RtsApi
  # This class is used to create a client that can send commands
  # to an RTS server and parse the responses
  class Client
    # it's unclear what <Version>1</Version> refers to
    # but it's the first child node in every request packet
    VERSION = 1

    Request = Struct.new(:packet, :command)

    def initialize(
      url: 'https://5.formovietickets.com:2235/Data.ASP',
      username: 'test',
      password: 'test',
      formatter: RequestPacketFormatter.new(VERSION),
      logger: nil
    )
      @url = url
      @username = username
      @password = password
      @formatter = formatter
      @logger = logger
      return if @logger
      @logger = ::Logger.new STDOUT
      @logger.level = ::Logger::WARN
    end

    # assume missing methods correspond to API "commands",
    # which should have corresponding methods in the packet formatter
    def method_missing(command, *args)
      return super unless respond_to_missing?(command)
      request_packet = @formatter.send(command, *args)
      request = Request.new(request_packet, command)
      res = get_response_with_logging(request)
      yield res if block_given?
      res
    end

    def respond_to_missing?(method, include_private = false)
      @formatter.methods.include?(method) || super
    end

    private

    def get_response(request)
      uri = URI(@url)
      req = Net::HTTP::Post.new(uri)
      req.basic_auth @username, @password
      req.content_type = 'text/xml'
      req.body = request.packet.to_s
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
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
