FROM openstack-base


ARG OS_PASSWORD
ARG GLANCE_PASS

ENV OS_PASSWORD=${OS_PASSWORD}
ENV GLANCE_PASS=${GLANCE_PASS}


WORKDIR /glance
RUN git clone -b stable/2026.1 --single-branch --depth 1 https://opendev.org/openstack/glance.git /glance


COPY ./glance-api.conf /etc/glance/glance-api.conf
COPY ./init.sh /glance/init.sh
COPY ./gunicorn.conf.py /glance/gunicorn.conf.py


RUN chmod +x /glance/init.sh


RUN pip install -r requirements.txt
RUN pip install gunicorn
RUN pip install -e .


EXPOSE 9292
RUN groupadd -r glance && useradd -r -g glance glance
CMD ["/glance/init.sh"]



