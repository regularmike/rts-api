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
        nil
      end
    end

    def get_children_as_array(element)
      begin
        ['ticket', 'ticket2']
      rescue
        nil
      end
    end

  end

end

