module RtsApi
  class Response
    attr_reader :http_status_code, :body

    include XMLReader
    
    def initialize(res)
      @http_status_code = res.code
      @body = res.body 
    end

    def packet
      @packet ||= Nokogiri::XML(@body)
    end

    def rts_response_code
      get_text_node('Code').to_i
    end
    
    def error_description
      if rts_response_code > 0
        get_text_node('ErrorText')  
      end
    end
  end
end

