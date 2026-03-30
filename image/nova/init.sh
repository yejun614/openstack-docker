#!/bin/bash

cd /nova


echo ----------------------------------------------------------
echo nova: Configuration

sed -i "s/NOVA_PASS/${NOVA_PASS}/g" /etc/nova/nova.conf
sed -i "s/PLACEMENT_PASS/${PLACEMENT_PASS}/g" /etc/nova/nova.conf




echo ----------------------------------------------------------
echo nova: DB SYNC

nova-manage api_db sync
nova-manage cell_v2 map_cell0
nova-manage cell_v2 create_cell --name=cell1 --verbose
nova-manage db sync
nova-manage cell_v2 list_cells




echo ----------------------------------------------------------
echo nova: WSGI Server Started

gunicorn


