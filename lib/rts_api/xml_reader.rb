module RtsApi
  module XmlReader
    def get_text_node(element, packet = self.packet)
      begin
        packet.at(element).text
      rescue
        ''        
      end
    end

    def get_node_set(element, packet = self.packet)
      begin
        packet.at(element).children
      rescue
        [] 
      end
    end
  end
end
