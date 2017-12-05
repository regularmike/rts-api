module RtsApi

  class ResponseFactory

    def self.create(command, res)
      case command
        when :performance_schedule then PerformanceSchedule.new(res)
        else Response.new(res)
      end
    end

  end

end
