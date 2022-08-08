FROM ubuntu:20.04
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install git pbuilder debhelper lsb-release fakeroot debian-archive-keyring debian-keyring -y
RUN apt-get install --reinstall ca-certificates -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository --update ppa:ubuntu-toolchain-r/test

# GCC/Clang
RUN DEBIAN_FRONTEND=noninteractive apt-get install git cmake ninja-build wget ccache gcc-11 g++-11 -y
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

# clickhouse src
RUN git clone --recursive https://github.com/ClickHouse/ClickHouse.git

RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
RUN tar -xvf clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
#RUN mkdir -p ClickHouse/build && cd ClickHouse/build \
#  &&  cmake .. -DCMAKE_CXX_COMPILER=/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/clang++  -DCMAKE_C_COMPILER=/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/clang \
#  && ninja
