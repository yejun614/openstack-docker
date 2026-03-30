FROM openstack-base


ARG OS_PASSWORD
ARG NOVA_PASS
ARG PLACEMENT_PASS

ENV OS_PASSWORD=${OS_PASSWORD}
ENV NOVA_PASS=${NOVA_PASS}
ENV PLACEMENT_PASS=${PLACEMENT_PASS}


WORKDIR /nova
RUN git clone -b stable/2026.1 --single-branch --depth 1 https://opendev.org/openstack/nova.git /nova


COPY ./nova.conf /etc/nova/nova.conf
COPY ./init.sh /nova/init.sh
COPY ./gunicorn.conf.py /nova/gunicorn.conf.py

RUN cp /nova/etc/nova/api-paste.ini /etc/nova/api-paste.ini
RUN chmod +x /nova/init.sh


RUN pip install -r requirements.txt
RUN pip install gunicorn
RUN pip install -e .


EXPOSE 8774
RUN groupadd -r nova && useradd -r -g nova nova
CMD ["/nova/init.sh"]



