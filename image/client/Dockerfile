FROM openstack-base

WORKDIR /client
RUN git clone -b stable/2026.1 --single-branch --depth 1 https://opendev.org/openstack/python-openstackclient.git /client
RUN pip install -r requirements.txt
RUN pip install -e .

RUN apt update && apt install -y iputils-ping curl mariadb-client

ARG OS_USERNAME
ARG OS_PASSWORD
ARG OS_PROJECT_NAME
ARG OS_USER_DOMAIN_NAME
ARG OS_PROJECT_DOMAIN_NAME
ARG OS_AUTH_URL
ARG OS_IDENTITY_API_VERSION
ARG USER_PASS
ARG GLANCE_PASS

ENV OS_USERNAME=${OS_USERNAME}
ENV OS_PASSWORD=${OS_PASSWORD}
ENV OS_PROJECT_NAME=${OS_PROJECT_NAME}
ENV OS_USER_DOMAIN_NAME=${OS_USER_DOMAIN_NAME}
ENV OS_PROJECT_DOMAIN_NAME=${OS_PROJECT_DOMAIN_NAME}
ENV OS_AUTH_URL=${OS_AUTH_URL}
ENV OS_IDENTITY_API_VERSION=${OS_IDENTITY_API_VERSION}
ENV USER_PASS=${USER_PASS}
ENV GLANCE_PASS=${GLANCE_PASS}

COPY init.sh /tmp/init.sh
RUN chmod +x /tmp/init.sh
CMD /tmp/init.sh && tail -f /dev/null
