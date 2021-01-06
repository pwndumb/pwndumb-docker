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
# install the necessary tools to pwn exploitation (I guess!!!)
#
RUN dpkg --add-architecture i386 && \
#
apt-get update && \
apt-get  install -y apt-utils build-essential jq strace \
ltrace curl wget rubygems gcc dnsutils netcat gcc-multilib \ 
net-tools vim gdb gdb-multiarch python python3 python3-pip  \
python3-dev libssl-dev libffi-dev wget git make procps \
libpcre3-dev libdb-dev libxt-dev libxaw7-dev python3-pip \
tmux xclip nodejs npm vim-gtk perl binutils rpm2cpio cpio \
zstd zsh bpython ipython3 p7zip-full tree hexyl sudo

#
# create tools directory and install some tools
RUN mkdir /root/tools && cd /root/tools && \
git clone https://github.com/radare/radare2 && cd radare2 && sys/install.sh && \
cd .. && git clone https://github.com/pwndbg/pwndbg && \ 
cd pwndbg && ./setup.sh && \
cd .. && \
git clone https://github.com/niklasb/libc-database && \
cd libc-database &&  \
cd .. && git clone https://github.com/JonathanSalwan/ROPgadget  && \
cd .. && gem install one_gadget && pip3 install pwntools && \
git clone https://github.com/samoshkin/tmux-config.git

#
# setup some customizations in vim,tmux and zshrc
WORKDIR /root
# Already installed my own vim files
COPY dotfiles.7z /root
RUN 7z x /root/dotfiles.7z
