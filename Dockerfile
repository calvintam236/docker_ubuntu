FROM ubuntu:18.04

LABEL maintainer="calvintam236"
LABEL description="Ubuntu with graphic driver installed in Docker."

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y --no-install-recommends install mesa-opencl-icd ocl-icd-opencl-dev \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

CMD ["/bin/bash"]
