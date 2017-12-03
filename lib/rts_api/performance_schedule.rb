module RtsApi

  class PerformanceSchedule < Response
    
    def file_version
      packet.at('FileVersion').text
    end

  end

end
