#!/bin/bash

# RabbitMQ 서버가 완전히 뜰 때까지 대기
rabbitmq-diagnostics -q check_running
until [ $? -eq 0 ]; do
  echo "Waiting for RabbitMQ..."
  sleep 2
  rabbitmq-diagnostics -q check_running
done

# 사용자 추가 및 권한 설정
rabbitmqctl set_permissions -p / openstack ".*" ".*" ".*"

echo "RabbitMQ configuration completed!"
