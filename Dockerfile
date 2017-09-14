FROM ubuntu:16.04

MAINTAINER calvintam236 <calvintam236@users.noreply.github.com>
LABEL description="Ubuntu with graphic driver installed in Docker."

WORKDIR /tmp

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y --no-install-recommends install ca-certificates curl \
    && curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub | apt-key add - \
    && curl -L -O https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb \
    && dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb \
    && rm cuda-repo-ubuntu1604_8.0.61-1_amd64.deb \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install cuda \
    && apt-get -y remove ca-certificates curl \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

CMD ["/bin/bash"]
