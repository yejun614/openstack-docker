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

if [[ -z "${DEPLOY_ENV}" ]]; then
    echo WARN: ADMIN_PASS is not defined
fi

keystone-manage bootstrap \
    --bootstrap-password "${ADMIN_PASS:-ADMIN_PASSWORD} "\
    --bootstrap-admin-url http://controller:5000/v3/ \
    --bootstrap-internal-url http://controller:5000/v3/ \
    --bootstrap-public-url http://controller:5000/v3/ \
    --bootstrap-region-id RegionOne

echo ----------------------------------------------------------
echo Keystone WSGI Server Started

gunicorn

