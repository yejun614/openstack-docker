#!/bin/bash

echo ----------------------------------------------------------
echo Client: Keystone Warming Up


openstack domain create --description "An Example Domain" example
openstack project create --domain default --description "Service Project" service

openstack project create --domain default --description "Demo Project" myproject
openstack user create --domain default --password ${USER_PASS} myuser
openstack role create myrole
openstack role add --project myproject --user myuser myrole



echo ----------------------------------------------------------
echo Client: Glance Warming Up


openstack user create --domain default --password ${GLANCE_PASS} glance
openstack role add --project service --user glance admin
openstack role add --user glance --user-domain Default --system all reader
openstack service create --name glance --description "OpenStack Image" image


openstack endpoint create --region RegionOne image public http://glance:9292
openstack endpoint create --region RegionOne image internal http://glance:9292
openstack endpoint create --region RegionOne image admin http://glance:9292


openstack registered limit create --service glance --default-limit 1000 --region RegionOne image_size_total
openstack registered limit create --service glance --default-limit 1000 --region RegionOne image_stage_total
openstack registered limit create --service glance --default-limit 100 --region RegionOne image_count_total
openstack registered limit create --service glance --default-limit 100 --region RegionOne image_count_uploading



## Glance 설정시 사용
openstack endpoint list --service glance --region RegionOne --interface internal -f value -c ID > /share/glance_endpoint.txt






echo ----------------------------------------------------------
echo Client: Placement Warming Up


openstack user create --domain default --password ${PLACEMENT_PASS} placement
openstack role add --project service --user placement admin
openstack service create --name placement --description "Placement API" placement


openstack endpoint create --region RegionOne placement public http://placement:8778
openstack endpoint create --region RegionOne placement internal http://placement:8778
openstack endpoint create --region RegionOne placement admin http://placement:8778





echo ----------------------------------------------------------
echo Client: Nova Warming Up


openstack user create --domain default --password ${NOVA_PASS} nova
openstack role add --project service --user nova admin
openstack service create --name nova --description "OpenStack Compute" compute


openstack endpoint create --region RegionOne compute public http://nova:8774/v2.1
openstack endpoint create --region RegionOne compute internal http://nova:8774/v2.1
openstack endpoint create --region RegionOne compute admin http://nova:8774/v2.1




echo ----------------------------------------------------------
echo Client: Warm-up Done

touch /tmp/script_done


