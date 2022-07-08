#Download base image ubuntu 18.04
FROM ubuntu:18.04

# LABEL about the custom image
LABEL maintainer="andy.mace@mediauk.net"
LABEL version="0.1"
LABEL description="Docker build for plutodatvfrm"

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Update Ubuntu Software repository
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install git
RUN git clone https://github.com/maceyldn/datvplutofrm.git

RUN apt-get install -y git build-essential fakeroot libncurses5-dev libssl-dev ccache 
RUN apt-get install -y dfu-util u-boot-tools device-tree-compiler libssl1.0-dev mtools
RUN apt-get install -y bc python cpio zip unzip rsync file wget

RUN git clone --recurse-submodules https://github.com/analogdevicesinc/plutosdr-fw.git



#Upgrade FFMPEG
#RUN rm -rf /plutosdr-fw/buildroot/packages/ffmpeg

WORKDIR datvplutofrm

#RUN cp -r /datvplutofrm/package/ffmpeg /plutosdr-fw/buildroot/packages
RUN cp /datvplutofrm/configs/f5oeo_zynq_pluto_defconfig /plutosdr-fw/buildroot/configs/f5oeo_zynq_pluto_defconfig

RUN mv /datvplutofrm/plutosdr_fw_patch/Makefile /plutosdr-fw/Makefile.orig
#Upgrade FFMPEG
#RUN rm -rf /plutosdr-fw/buildroot/packages/ffmpeg

WORKDIR /plutosdr-fw
RUN make -j 4


#RUN ./config-firmware.sh
