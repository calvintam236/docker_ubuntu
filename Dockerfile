FROM ubuntu:16.04

LABEL maintainer="calvintam236"
LABEL description="Ubuntu with graphic driver installed in Docker."

RUN apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y --no-install-recommends install ca-certificates curl gnupg-curl \
    && curl -L -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.2.148-1_amd64.deb \
    && dpkg -i cuda-repo-ubuntu1604_9.2.148-1_amd64.deb \
    && rm cuda-repo-ubuntu1604_9.2.148-1_amd64.deb \
    && apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install cuda \
    && export PATH=/usr/local/cuda-9.2/bin${PATH:+:${PATH}} \
    && apt-get -y remove ca-certificates curl \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

CMD ["/bin/bash"]
