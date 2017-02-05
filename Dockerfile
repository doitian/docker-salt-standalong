FROM ubuntu-upstart:trusty

RUN wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add - \
 && apt-get update -y \
 && apt-get install -y salt-minion \
 && rm -rf /var/lib/apt/lists/*

COPY minion /etc/salt/
COPY vendor/bats/bin /usr/local/bin/
COPY vendor/bats/libexec /usr/local/libexec/

WORKDIR /srv
CMD [ "bats", "/srv/test" ]
