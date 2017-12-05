module RtsApi

  class Response

    attr_reader :code, :body
    
    def initialize(res)
      @code = res.code
      @body = res.body 
    end

    def packet
      @packet ||= Nokogiri::XML(@body)
    end

  end

end
