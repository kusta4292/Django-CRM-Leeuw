FROM python:3.11-slim

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  default-libmysqlclient-dev \
  libjpeg62-turbo-dev \
  zlib1g-dev \
  libwebp-dev \
  curl \
  vim \
  net-tools && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install gunicorn

ENV PATH="/app/scripts:${PATH}"

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "crm.wsgi:application"]

# FROM ubuntu:20.04

# # invalidate cache
# ARG APP_NAME

# # test arg
# RUN test -n "$APP_NAME"

# # install system packages
# RUN apt-get update -y
# RUN apt-get install -y \
#   python3-pip \
#   python3-venv \
#   build-essential \
#   libpq-dev \
#   libmariadbclient-dev \
#   libjpeg62-dev \
#   zlib1g-dev \
#   libwebp-dev \
#   curl  \
#   vim \
#   net-tools

# # setup user
# RUN useradd -ms /bin/bash ubuntu
# USER ubuntu

# # install app
# RUN mkdir -p /home/ubuntu/"$APP_NAME"/"$APP_NAME"
# WORKDIR /home/ubuntu/"$APP_NAME"/"$APP_NAME"
# COPY . .
# RUN python3 -m venv ../venv
# RUN . ../venv/bin/activate
# RUN /home/ubuntu/"$APP_NAME"/venv/bin/pip install -U pip
# RUN /home/ubuntu/"$APP_NAME"/venv/bin/pip install -r requirements.txt
# RUN /home/ubuntu/"$APP_NAME"/venv/bin/pip install gunicorn

# # setup path
# ENV PATH="${PATH}:/home/ubuntu/$APP_NAME/$APP_NAME/scripts"

# USER ubuntu
