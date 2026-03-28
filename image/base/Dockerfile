FROM python:3.11-slim

WORKDIR /works

RUN apt update && apt install -y git

COPY requirements.txt /works/requirements.txt
RUN pip install -r requirements.txt

CMD ["tail", "-f", "/dev/null"]
