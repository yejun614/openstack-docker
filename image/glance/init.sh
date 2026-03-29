#!/bin/bash

cd /glance


echo ----------------------------------------------------------
echo Glance: Configuration

GLANCE_ENDPOINT=$(cat /share/glance_endpoint.txt)

sed -i "s/ENDPOINT_ID/${GLANCE_ENDPOINT}/g" /etc/glance/glance-api.conf
sed -i "s/GLANCE_PASS/${GLANCE_PASS}/g" /etc/glance/glance-api.conf




echo ----------------------------------------------------------
echo glance: DB SYNC

glance-manage db_sync




echo ----------------------------------------------------------
echo Glance: WSGI Server Started

gunicorn


