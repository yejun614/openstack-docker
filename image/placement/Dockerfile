FROM openstack-base


ARG OS_PASSWORD
ARG PLACEMENT_PASS

ENV OS_PASSWORD=${OS_PASSWORD}
ENV PLACEMENT_PASS=${PLACEMENT_PASS}


WORKDIR /placement
RUN git clone -b stable/2026.1 --single-branch --depth 1 https://opendev.org/openstack/placement.git /placement


COPY ./placement.conf /etc/placement/placement.conf
COPY ./init.sh /placement/init.sh
COPY ./gunicorn.conf.py /placement/gunicorn.conf.py


RUN chmod +x /placement/init.sh


RUN pip install -r requirements.txt
RUN pip install gunicorn
RUN pip install -e .


EXPOSE 8778
RUN groupadd -r placement && useradd -r -g placement placement
CMD ["/placement/init.sh"]



