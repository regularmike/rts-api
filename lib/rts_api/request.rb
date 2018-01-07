module RtsApi
  class Request
    attr_reader :packet, :command

    def initialize(packet, command)
      @packet = packet
      @command = command
    end
  end
end
