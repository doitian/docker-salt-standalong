FROM ubuntu-upstart:trusty

WORKDIR /srv

COPY vendor/bats/bin /usr/local/bin/
COPY vendor/bats/libexec /usr/local/libexec/

RUN wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add - \
 && echo 'deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main' > /etc/apt/sources.list.d/saltstack.list

RUN apt-get update -y \
 && apt-get install -y salt-minion rsync \
 && rm -rf /var/lib/apt/lists/*

COPY minion /etc/salt/

