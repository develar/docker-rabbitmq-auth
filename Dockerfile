FROM rabbitmq:3.5.3-management
MAINTAINER Vladimir Krivosheev <develar@gmail.com>

COPY rabbitmq_auth_backend_http-3.5.x-0.ez /usr/lib/rabbitmq/lib/rabbitmq_server-3.5.3/plugins/rabbitmq_auth_backend_http-3.5.x-0.ez
RUN rabbitmq-plugins enable --offline rabbitmq_auth_backend_http rabbitmq_management_visualiser rabbitmq_web_stomp

COPY rabbitmq.config /etc/rabbitmq/rabbitmq.config

EXPOSE 5671 4443