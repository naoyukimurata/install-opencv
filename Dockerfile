FROM python:3.4

# Install python and pip
RUN apt-get update
RUN apt-get install -y --no-install-recommends sqlite3
RUN apt-get install -y git
RUN apt-get install -y python3-dev
RUN apt-get install -y python3-pip
RUN pip3 install numpy
RUN apt-get install -y libpq-dev
RUN apt-get install -y build-essential libssl-dev libffi-dev
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app
ADD requirements.txt /usr/src/app

# OpenCVインストール
ADD ./opencv_install.sh /usr/src/app
WORKDIR /usr/src/app
RUN echo 'deb http://archive.ubuntu.com/ubuntu trusty multiverse' >> /etc/apt/sources.list && apt-get update
RUN ./opencv_install.sh

RUN pip install --upgrade pip
RUN pip3 install -r /usr/src/app/requirements.txt

# srcのフォルダを全てapp以下にコピー
ONBUILD ADD . /usr/src/app/