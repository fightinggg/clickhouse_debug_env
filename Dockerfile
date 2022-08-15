FROM ubuntu:20.04
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install git pbuilder debhelper lsb-release fakeroot debian-archive-keyring debian-keyring -y
RUN apt-get install --reinstall ca-certificates -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository --update ppa:ubuntu-toolchain-r/test

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

# clickhouse src
# RUN git clone --recursive https://github.com/ClickHouse/ClickHouse.git

# Build
# RUN mkdir -p ClickHouse/build && cd ClickHouse/build \
#  &&  cmake .. -DCMAKE_CXX_COMPILER=/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/clang++  -DCMAKE_C_COMPILER=/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/clang \
#  && ninja

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"] 