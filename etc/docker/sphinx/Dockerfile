FROM python:3.6-jessie

LABEL maintainer="pierre.groth@db-n.com"

#RUN apt-get update \
#    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends python3-sphinx \
#    && apt-get clean \
#    && rm -rf /var/lib/apt/lists/*

RUN pip install -U sphinx

ENV GOSU_VERSION 1.10

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends wget \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -d "/home/sphinx" -m -s /bin/bash sphinx

RUN mkdir /sphinx \
    && chown sphinx:sphinx /sphinx

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /sphinx

ENTRYPOINT ["entrypoint.sh"]
