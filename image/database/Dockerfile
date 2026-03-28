FROM mariadb:12.3.1-ubi10-rc

COPY ./99-openstack.cnf /etc/mysql/conf.d/99-openstack.cnf
COPY ./init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306
