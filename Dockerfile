FROM ubuntu:16.04

LABEL maintainer="calvintam236"
LABEL description="Ubuntu with graphic driver installed in Docker."

WORKDIR /tmp

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y --no-install-recommends install ca-certificates curl \
    && curl -L -O http://repo.radeon.com/rocm/apt/debian/rocm.gpg.key \
    && apt-key add rocm.gpg.key \
    && rm rocm.gpg.key \
    && echo 'deb [arch=amd64] http://repo.radeon.com/rocm/apt/debian/ xenial main' > /etc/apt/sources.list.d/rocm.list \
    && apt-get update \
    && apt-get -y --no-install-recommends install rocm-dev \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

CMD ["/bin/bash"]
