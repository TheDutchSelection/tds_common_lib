require 'tds_common_lib/version'
require 'tds_common_lib/engine'
require 'tds_common_lib/configuration'

module TdsCommonLib
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
