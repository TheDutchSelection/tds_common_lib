module TdsCommonLib
  class ResqueService

    def initialize
    end

    def continue_processing
      if resque_pool_manager_pid > 0
        syscmd = "kill -s CONT #{resque_pool_manager_pid}"
        system(syscmd)
      end
    end

    def stop_processing
      # when sending USR2 to the Resque Pool manager process, the workers finish and don't start accepting new jobs
      if resque_pool_manager_pid > 0
        syscmd = "kill -s USR2 #{resque_pool_manager_pid}"
        system(syscmd)
      end
    end

    def stop_processing_and_wait(max_waiting_seconds)
      stop_processing

      start_time = Time.now
      time_running = 0
      while workers_working? && time_running < max_waiting_seconds
        time_running = Time.now - start_time
        sleep 5
      end
    end

    def workers_working?
      Resque.working.any?
    end

    private

    def resque_pool_manager_pid
      `pgrep -f resque-pool-master`.to_i
    end
  end
end
