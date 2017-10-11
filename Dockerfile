FROM ubuntu:16.04

MAINTAINER calvintam236 <calvintam236@users.noreply.github.com>
LABEL description="Ubuntu with graphic driver installed in Docker."

WORKDIR /tmp

RUN apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y --no-install-recommends install lsb-release software-properties-common wget \
    && wget -qO - http://repo.radeon.com/rocm/apt/debian/rocm.gpg.key | apt-key add - \
    && add-apt-repository "deb [arch=amd64] http://repo.radeon.com/rocm/apt/debian/ $(lsb_release -cs) main" \
    && apt-get update \
    && apt-get -y --no-install-recommends install rocm-dev rocm-opencl \
    && apt-get -y remove lsb-release software-properties-common wget \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

CMD ["/bin/bash"]
