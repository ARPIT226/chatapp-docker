# Use Ubuntu 21.04 as base image
FROM ubuntu:22.04

# Avoid tzdata interactive prompt
ENV DEBIAN_FRONTEND=noninteractive

# Set base working directory inside container
WORKDIR /chatapp

# Install system packages
RUN apt-get update && apt-get install -y gnupg ca-certificates

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && \
    apt-get install -y \
        git \
        curl \
        gcc \
        python3.8 \
        python3.8-venv \
        python3.8-dev \
        python3.8-distutils \
        default-libmysqlclient-dev \
        build-essential \
        pkg-config


# Install pip for Python 3.8
RUN curl -sS https://bootstrap.pypa.io/pip/3.8/get-pip.py | python3.8

# Set python3.8 as default
RUN ln -sf /usr/bin/python3.8 /usr/bin/python

RUN rm -rf /chatapp && mkdir -p /chatapp 

# Clone the Django app repo into /chatapp (secret token for private repository access) (uncomment below while running)
#RUN git clone --depth=1 https://{secret-token}@github.com/ARPIT226/chat_app.git /chatapp

# Copy env variables to chatapp 
COPY .env /chatapp/.env

# Create Python virtual environment
RUN python -m venv /chatapp/venv

# Upgrade pip
RUN /chatapp/venv/bin/pip install --upgrade pip

# Install Python dependencies
RUN /chatapp/venv/bin/pip install -r /chatapp/requirements.txt

# Install additional packages
RUN /chatapp/venv/bin/pip install mysqlclient gunicorn

# Set working directory to Django project root (where manage.py is)
WORKDIR /chatapp/fundoo

# Expose Django/Gunicorn port
EXPOSE 8000

# Run Gunicorn and load environment variables from .env file
CMD ["/bin/bash", "-c", "set -a && source /chatapp/.env && set +a && /chatapp/venv/bin/gunicorn --bind 0.0.0.0:8000 fundoo.wsgi:application"]
