module RtsApi

  class PerformanceSchedule < Response
    
    def file_version
      packet.at('FileVersion').text
    end

    def rts_version
      packet.at('RtsVersion').text
    end

    def link_prefix
      packet.at('LinkPreFix').text
    end

  end

end
