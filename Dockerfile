# for build run 
# docker build -t pwndocker:ubuntu20.10 .

# For run following instrutions 
## If using Windows
      ### docker run --rm -v %cd%:/pwd --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -d --name pwndocker -i pwndocker:ubuntu20.10
## If using Linux    
      ### docker run --rm -v $PWD:/pwd --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -d --name pwndocker -i pwndocker:ubuntu20.10
## docker exec -it pwndocker /bin/bash


# download base image ubuntu 20.10
FROM ubuntu:20.10
#
# setup enviroment variables
#
ENV LC_CTYPE C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
#
# set apt to noninteractive
#
ARG DEBIAN_FRONTEND=noninteractive
#
# install the necessary tools to pwn exploitation in linux
#
RUN dpkg --add-architecture i386 && \
#
apt-get update && \
apt-get  install -y apt-utils build-essential strace \
ltrace curl rubygems gcc dnsutils netcat gcc-multilib \ 
gdb gdb-multiarch python python3 python3-pip  \
python3-dev libssl-dev libffi-dev wget git make procps \
libpcre3-dev libdb-dev libxt-dev libxaw7-dev python3-pip \
tmux perl binutils rpm2cpio cpio python3-setuptools \
bpython p7zip-full tree hexyl sudo meson cmake

#
# create tools directory and install some tools
RUN mkdir /root/tools && cd /root/tools && \
git clone https://github.com/rizinorg/rizin && cd rizin && \
meson build && ninja -C build && ninja -C build install && \
cd .. && git clone https://github.com/pwndbg/pwndbg && \ 
cd pwndbg && ./setup.sh && cd .. && \
git clone https://github.com/JonathanSalwan/ROPgadget  && \
pip3 install pwntools && rz-pm init && \
rz-pm -i rz-ghidra

