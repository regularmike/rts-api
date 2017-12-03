module RtsApi

  class ResponseFactory

    def self.create(command, res)
      case command
        when :performance_schedule then RtsApi::PerformanceSchedule.new(res)
      end
    end

  end

end
