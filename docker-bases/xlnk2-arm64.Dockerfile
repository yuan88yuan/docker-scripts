FROM ubuntu:24.04 AS builder

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y bash-completion git vim wget cpio tcl locales libexpat1 libkeyutils1
RUN locale-gen zh_TW.UTF-8 && update-locale
RUN apt-get install -y python3 xz-utils file

# platform SDK
ADD sdk.sh /tmp/
RUN cd /tmp && chmod +x ./sdk.sh && ./sdk.sh -y -d /opt/sc6f0
RUN ln /opt/sc6f0/environment-setup-cortexa72-cortexa53-xilinx-linux /opt/qcap-dev-init -fs && \
chmod +x /opt/qcap-dev-init

RUN apt-get install -y build-essential
