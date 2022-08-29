FROM ubuntu:20.04
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install git pbuilder debhelper lsb-release fakeroot debian-archive-keyring debian-keyring -y
RUN apt-get install --reinstall ca-certificates -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository --update ppa:ubuntu-toolchain-r/test
RUN apt-get install lsof vim rsync -y


# Clang
RUN DEBIAN_FRONTEND=noninteractive apt-get install git cmake ninja-build wget ccache -y
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

# SSH
RUN apt-get install ssh -y
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config; \
ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key -y; \
ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -y; \
ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -y; \
mkdir /run/sshd

RUN echo root:123456 | chpasswd

# Key
## https://xiaoyu.blog.csdn.net/article/details/123840123?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-123840123-blog-51498724.pc_relevant_multi_platform_whitelistv4&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-123840123-blog-51498724.pc_relevant_multi_platform_whitelistv4&utm_relevant_index=1
RUN echo -e "bind -x '\"\C-l\": clear;'" > /root/.bashrc

# clickhouse src
# RUN git clone --recursive https://github.com/ClickHouse/ClickHouse.git

# Build
# RUN mkdir -p ClickHouse/build && cd ClickHouse/build \
#  &&  cmake .. -DCMAKE_CXX_COMPILER=/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/clang++  -DCMAKE_C_COMPILER=/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/clang \
#  && ninja

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"] 
