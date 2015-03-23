FROM develar/rabbitmq:3.5.0-management
MAINTAINER Vladimir Krivosheev <develar@gmail.com>

ENV AUTH_HOST mq-auth

RUN apt-get update && apt-get install -y wget --no-install-recommends && \
  cd /usr/lib/rabbitmq/lib/rabbitmq_server-*/plugins && \
  wget http://www.rabbitmq.com/community-plugins/v3.5.x/rabbitmq_auth_backend_http-3.5.x-fe9401c6.ez && \
  apt-get -y --purge autoremove wget && rm -rf /var/lib/apt/lists/*

RUN echo "[{rabbit, [{auth_backends, [rabbit_auth_backend_http]}]}, {rabbitmq_auth_backend_http, \
             [{user_path,     \"http://$AUTH_HOST/user\"}, \
              {vhost_path,    \"http://$AUTH_HOST/vhost\"}, \
              {resource_path, \"http://$AUTH_HOST/resource\"}]} \
          ]." > /etc/rabbitmq/rabbitmq.config && \
  rabbitmq-plugins enable --offline rabbitmq_auth_backend_http rabbitmq_web_stomp && \
  touch /.rabbitmq_password_set