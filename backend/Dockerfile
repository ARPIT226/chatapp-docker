FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies and Python 3.8 from deadsnakes
RUN apt-get update && \
    apt-get install -y software-properties-common curl git && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && \
    apt-get install -y python3.8 python3.8-venv python3.8-dev \
        gcc build-essential default-libmysqlclient-dev \
        pkg-config netcat-openbsd && \
    apt-get clean

# Set working directory
WORKDIR /app

# Clone your repo
RUN git clone https://github.com/ARPIT226/chat_app.git /app

# Create virtual environment with Python 3.8 and install dependencies
RUN python3.8 -m venv venv && \
    ./venv/bin/pip install --upgrade pip && \
    ./venv/bin/pip install -r requirements.txt && \
    ./venv/bin/pip install gunicorn mysqlclient

# Environment variables
ENV DB_NAME=chatappdb \
    DB_USER=arpit \
    DB_PASSWORD=Jodhpur@21 \
    DB_HOST=mysql-container \
    DB_PORT=3306

# Start command
CMD bash -c '\
  echo "Waiting for MySQL at $DB_HOST:$DB_PORT..." && \
  until nc -z "$DB_HOST" "$DB_PORT"; do sleep 2; echo "Waiting..."; done && \
  echo "DB is ready!" && \
  /app/venv/bin/python /app/fundoo/manage.py migrate && \
  exec /app/venv/bin/gunicorn --chdir /app/fundoo --bind 0.0.0.0:8000 fundoo.wsgi:application'
