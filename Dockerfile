FROM ubuntu:18.04

LABEL maintainer="calvintam236"
LABEL description="Ubuntu with graphic driver installed in Docker."

WORKDIR /tmp

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y --no-install-recommends install ca-certificates curl xz-utils \
    && curl -L -O --referer https://www.amd.com https://drivers.amd.com/drivers/linux/amdgpu-pro-18.50-708488-ubuntu-18.04.tar.xz \
    && tar -Jxvf amdgpu-pro-18.50-708488-ubuntu-18.04.tar.xz \
    && rm amdgpu-pro-18.50-708488-ubuntu-18.04.tar.xz \
    && ./amdgpu-pro-18.50-708488-ubuntu-18.04/amdgpu-install -y --headless --opencl=legacy,pal \
    && rm -r amdgpu-pro-18.50-708488-ubuntu-18.04 \
    && apt-get -y remove ca-certificates curl xz-utils \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

CMD ["/bin/bash"]
