module TdsCommonLib
  module RequestQueryable
    extend ActiveSupport::Concern

    def remote_ip
      # if you want to debug wrong values for remote_ip
      #
      # Rails.logger.fatal("HTTP_CLIENT_IP: #{request.env['HTTP_CLIENT_IP']}")
      # Rails.logger.fatal("REMOTE_ADDR: #{request.env['REMOTE_ADDR']}")
      # Rails.logger.fatal("HTTP_X_FORWARDED_FOR: #{request.env['HTTP_X_FORWARDED_FOR']}")
      @remote_ip ||= request.remote_ip
    end

    def request_referer
      @request_referer ||= request.referrer
    end
  end
end