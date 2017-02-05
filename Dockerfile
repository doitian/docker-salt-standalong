FROM buildpack-deps:jessie-curl

RUN curl -L -o - https://repo.saltstack.com/apt/debian/8/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add - \
 && apt-get update -y \
 && apt-get install -y salt-minion \
 && rm -rf /var/lib/apt/lists/*

COPY minion /etc/salt/
COPY [ 'vendor/bats/bin', 'vendor/bats/libexec', '/usr/local/' ]

WORKDIR /srv
CMD [ 'bats', '/srv/test' ]
