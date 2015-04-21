FROM develar/rabbitmq:3.5.0-management
MAINTAINER Vladimir Krivosheev <develar@gmail.com>

RUN apt-get update && apt-get install -y wget --no-install-recommends && \
  cd /usr/lib/rabbitmq/lib/rabbitmq_server-*/plugins && \
  wget http://www.rabbitmq.com/community-plugins/v3.5.x/rabbitmq_auth_backend_http-3.5.x-fe9401c6.ez && \
  apt-get -y --purge autoremove wget && rm -rf /var/lib/apt/lists/* && \
  rabbitmq-plugins enable --offline rabbitmq_auth_backend_http rabbitmq_management_visualiser rabbitmq_web_stomp

COPY rabbitmq.config /etc/rabbitmq/rabbitmq.config

EXPOSE 4433