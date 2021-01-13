module TdsCommonLib
  module Cacheable
    extend ActiveSupport::Concern

    # We use cache headers in production to let Varnish know it can cache the page. Varnish removes the cache headers,
    # so the page is not cached by the browser (Rails default)
    def set_cache_control_headers(max_age = 1.day)
      request.session_options[:skip] = true
      if Rails.env.production?
        expires_in(max_age, public: true)
      end
    end
  end
end
