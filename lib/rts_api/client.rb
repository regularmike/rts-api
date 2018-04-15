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

    # send a request to the server
    # This method should not be called directly but by an alias
    # that corresponds to an API command
    def make_request(*args)
      command = __callee__
      request_packet = @formatter.send(command, *args)
      request = Request.new(request_packet, command)
      res = get_response_with_logging(request)
      yield res if block_given?
      res
    end

    %i[
      performance_schedule
      gift_card_loyalty_card_information
      purchase_gift_card
    ].each { |command| alias_method command, :make_request }

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
