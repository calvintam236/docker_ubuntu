FROM ubuntu:16.04

LABEL maintainer="calvintam236"
LABEL description="Ubuntu with graphic driver installed in Docker."

WORKDIR /tmp

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y --no-install-recommends install ca-certificates curl xz-utils \
    && curl -L -O --referer https://support.amd.com https://www2.ati.com/drivers/linux/ubuntu/amdgpu-pro-18.20-606296.tar.xz \
    && tar -Jxvf amdgpu-pro-18.20-606296.tar.xz \
    && rm amdgpu-pro-18.20-606296.tar.xz \
    && ./amdgpu-pro-18.20-606296/amdgpu-install -y --headless --opencl=legacy,pal \
    && rm -r amdgpu-pro-18.20-606296 \
    && apt-get -y remove ca-certificates curl xz-utils \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

CMD ["/bin/bash"]
