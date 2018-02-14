module RtsApi
  # Adds the ability to grab a text node or array of nodes from an XML document
  module XMLReader
    def text_node(element, packet = self.packet)
      packet.at(element).text
    rescue NoMethodError
      ''
    end

    def node_set(element, packet = self.packet)
      packet.at(element).children
    rescue NoMethodError
      []
    end
  end
end
