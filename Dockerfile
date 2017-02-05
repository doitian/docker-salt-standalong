FROM buildpack-deps:jessie-curl

RUN curl -L -o - https://repo.saltstack.com/apt/debian/8/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add - \
 && echo 'deb http://repo.saltstack.com/apt/debian/8/amd64/latest jessie main' > /etc/apt/sources.list.d/saltstack.list \
 && apt-get update -y \
 && apt-get install -y salt-minion \
 && rm -rf /var/lib/apt/lists/*

COPY minion /etc/salt/
COPY vendor/bats/bin /usr/local/bin/
COPY vendor/bats/libexec /usr/local/libexec/

WORKDIR /srv
CMD [ 'bats', '/srv/test' ]
