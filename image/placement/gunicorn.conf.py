# gunicorn.conf.py 예시

root_path = "/placement"

# 1. 네트워크 설정
bind = "0.0.0.0:8778"

# 2. 프로세스 및 성능 (CPU 코어 수 기반 권장: cores * 2 + 1)
workers = 1
worker_class = "sync"
timeout = 60           # 토큰 생성 등 무거운 작업 대비

# 3. 로깅 (Docker 환경에서는 '-'를 써서 표준 출력으로 보냄)
accesslog = "-"
errorlog = "-"
loglevel = "info"

# 4. WSGI 함수
wsgi_app = "placement.wsgi.api:application"
