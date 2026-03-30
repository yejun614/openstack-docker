FROM mariadb:12.3.1-noble-rc
# FROM openstack-base

COPY ./99-openstack.cnf /etc/mysql/conf.d/99-openstack.cnf
COPY ./init.sql /docker-entrypoint-initdb.d/

RUN mkdir -p /var/log/mysql

EXPOSE 3306
