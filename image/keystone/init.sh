#!/bin/bash

cd /keystone

echo ----------------------------------------------------------
echo Keystone DB SYNC

keystone-manage db_sync

echo ----------------------------------------------------------
echo Keystone Manager fernet setup

keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone

echo ----------------------------------------------------------
echo Keystone Manager credential setup

keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

echo ----------------------------------------------------------
echo Keystone Manager bootstrap

if [[ -z "${OS_PASSWORD}" ]]; then
    echo WARN: OS_PASSWORD is not defined
fi

keystone-manage bootstrap \
    --bootstrap-password "${OS_PASSWORD:-ADMIN_PASS}" \
    --bootstrap-admin-url http://controller:5000/v3/ \
    --bootstrap-internal-url http://controller:5000/v3/ \
    --bootstrap-public-url http://controller:5000/v3/ \
    --bootstrap-region-id RegionOne

echo ----------------------------------------------------------
echo Keystone WSGI Server Started

gunicorn

