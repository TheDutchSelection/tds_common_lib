# NAME: TDS Common Lib
#
# DESCRIPTION: TDS Common Lib image which runs the TDS Common Library. This image is to run tests only.
#
# REQUIRD ENVS:
# DATABASE_HOST (ie. "10.0.0.1")
# DATABASE_PORT (ie. "5432")
# RAILS_ENV (ie. "production")
# REDIS_HOST (ie. "10.0.0.1")
# REDIS_PORT (ie. "3367")
# RUN_TYPE (in: backend, portal, spec_features, test, worker)
#
# OPTIONAL ENVS:
# DATABASE_USER (ie. "wr_core")
# DATABASE_PASSWORD (ie. "abcdabcd")
# HAPROXY_SERVER_IPS (ie. "123.123.123.123 212.212.212.212")
# PUMA_WORKERS (ie. "2")
# RAILS_MASTER_KEY (ie. "hdtfr3658df")
# REDIS_PASSWORD (ie. "fsegdfs")
# REDIS_DATABASE (ie. "0")
# RUN_MIGRATIONS (ie. "1")
# TERM_CHILD (ie. "1")
# RSPEC_OPTS (ie. "--seed 10000 spec/features", only applicable when RUN_TYPE is "test")
# VARNISH_ENDPOINTS (ie. "http://10.0.0.1:6081 http://10.0.0.2:6081", only for backend and worker)

FROM thedutchselection/app_env_tds_common_lib:latest
MAINTAINER Gerard Meijer <g.meijer@thedutchselection.com>

ADD --chown=appmaster:appmaster ./ /home/appmaster/application
ADD --chown=appmaster:appmaster ./public /home/appmaster/application/public_original

RUN bundle install

USER appmaster

ENV HOME /home/appmaster

RUN yarn install --network-timeout 1000000 --pure-lockfile

ADD config/docker/files/scripts /usr/local/bin

EXPOSE 3000

ENTRYPOINT ["/bin/bash", "/usr/local/bin/run.sh"]
