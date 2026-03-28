FROM openstack-base:local


ARG ADMIN_PASS
ENV ADMIN_PASS=${ADMIN_PASS}


WORKDIR /keystone
RUN git clone -b stable/2026.1 --single-branch --depth 1 https://opendev.org/openstack/keystone.git /keystone


COPY ./keystone.conf /etc/keystone/keystone.conf
COPY ./init.sh /keystone/init.sh
COPY ./gunicorn.conf.py /keystone/gunicorn.conf.py


RUN chmod +x /keystone/init.sh


RUN pip install -r requirements.txt
RUN pip install gunicorn
RUN pip install -e .


EXPOSE 5000
RUN groupadd -r keystone && useradd -r -g keystone keystone
CMD ["/keystone/init.sh"]

