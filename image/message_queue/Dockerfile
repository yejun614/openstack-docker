FROM rabbitmq:4.3.0-rc.0-management

WORKDIR /works

ARG RABBIT_PASS

ENV RABBITMQ_DEFAULT_USER=openstack
ENV RABBITMQ_DEFAULT_PASS=${RABBIT_PASS}

COPY init.sh /works/init.sh
RUN chmod +x /works/init.sh

CMD ["sh", "-c", "/works/init.sh & docker-entrypoint.sh rabbitmq-server"]
