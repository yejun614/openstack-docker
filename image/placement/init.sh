#!/bin/bash

cd /placement


echo ----------------------------------------------------------
echo placement: Configuration

sed -i "s/PLACEMENT_PASS/${PLACEMENT_PASS}/g" /etc/placement/placement.conf




echo ----------------------------------------------------------
echo placement: DB SYNC

placement-manage db sync




echo ----------------------------------------------------------
echo placement: WSGI Server Started

gunicorn


