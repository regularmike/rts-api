require 'nokogiri'

module RtsApi

  class Response

    attr_reader :code, :body
    
    def initialize(res)
      @code = res.code
      @body = res.body 
    end

    def xml_doc
      Nokogiri::XML(@body)
    end

  end

end

