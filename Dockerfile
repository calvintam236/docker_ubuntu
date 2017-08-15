FROM ubuntu:16.04

MAINTAINER calvintam236 <calvintam236@users.noreply.github.com>
LABEL description="Ubuntu with graphic driver installed in Docker."

WORKDIR /tmp

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get -y --no-install-recommends install ca-certificates curl xz-utils \
    && curl -L -O --referer https://support.amd.com https://www2.ati.com/drivers/linux/ubuntu/amdgpu-pro-17.30-465504.tar.xz \
    && tar -Jxvf amdgpu-pro-17.30-465504.tar.xz \
    && rm amdgpu-pro-17.30-465504.tar.xz \
    && ./amdgpu-pro-17.30-465504/amdgpu-pro-install -y \
    && rm -r amdgpu-pro-17.30-465504 \
    && apt-get -y remove ca-certificates curl xz-utils \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log} \
    && usermod -a -G video root

CMD ["/bin/bash"]
