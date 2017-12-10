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

    private

    def get_text_node(element)
      begin
        packet.at(element).text
      rescue
        ''        
      end
    end

    def get_node_set(element)
      begin
        packet.at(element).children
      rescue
        [] 
      end
    end

  end

end

