#!/bin/bash


# VM 내부 Docker를 조작
export DOCKER_HOST="ssh://debian@localhost:1804"

# docker compose down --volumes
# exit


# 모든 서비스가 healthy 상태가 될 때까지 대기하는 함수
wait_for_healthy() {
    
    while true; do
        # 실행 중인 모든 컨테이너의 상태를 가져옴
        # 'starting'이나 'unhealthy' 상태가 있는지 확인
        STATUS=$(docker compose ps --format json | jq -r '.[].Health' 2>/dev/null)
        
        # 만약 아직 시작 중(starting)이거나 하나라도 비정상(unhealthy)이면 대기
        if echo "$STATUS" | grep -qE "starting|unhealthy"; then
            echo "⏳ 모든 서비스가 준비될 때까지 대기 중..."
            sleep 10
        else
            # 모든 서비스가 'healthy'이거나 헬스체크가 없는 서비스만 남은 경우
            break
        fi
    done

    echo "🚀 이제 OpenStack 명령어를 실행할 수 있습니다."
}


# Glance 서비스 테스트를 위한 CirrOS img 다운로드
if [ ! -f "img/cirros-0.4.0-x86_64-disk.img" ]; then
    wget http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img -P img
fi


# 이미지 빌드
docker build -t openstack-base ../image/base
docker build -t openstack-client ../image/client
docker compose build


# 컨테이너 시작
docker compose up
# 컨테이너가 준비될때까지 대기
wait_for_healthy
# 컨테이너 올라가면 OpenStack Client로 이동
docker exec -it openstack-client bash

# 올렸던 컨테이너 전부 내리기
docker compose down --volumes
# 임시 파일 삭제
# rm -rf ./log ./volume ./share


# 환경변수 삭제
unset DOCKER_HOST

