module RtsApi

  class PerformanceSchedule < Response
    
    def file_version
      get_text_node('FileVersion') 
    end

    def rts_version
      get_text_node('RtsVersion') 
    end

    def link_prefix
      get_text_node('LinkPreFix')
    end

    def tickets
      get_children_as_array('Tickets')
    end

  end

end
