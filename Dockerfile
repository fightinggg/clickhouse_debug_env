FROM ubuntu:20.04
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository --update ppa:ubuntu-toolchain-r/test
RUN DEBIAN_FRONTEND=noninteractive apt-get install git cmake ninja-build wget ccache gcc-11 g++-11 -y


# clickhouse src
RUN git clone --recursive https://github.com/ClickHouse/ClickHouse.git \
 && cd ClickHouse \
 && ls -F contrib | sed  "s/$/.git/g" | sed "s/^/contrib\//g" | xargs rm -rf \
 && rm -rf .git


# pbuilder debhelper lsb-release fakeroot debian-archive-keyring debian-keyring  ca-certificates
# RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
# RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
# RUN tar -xvf clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz

RUN mkdir -p ClickHouse/build && cd ClickHouse/build \
 && cmake .. -DCMAKE_CXX_COMPILER=/usr/bin/g++-11 -DCMAKE_C_COMPILER=/usr/bin/gcc-11 \
 && ninja

