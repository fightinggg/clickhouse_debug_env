FROM ubuntu:20.04
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install git pbuilder debhelper lsb-release fakeroot debian-archive-keyring debian-keyring -y
RUN apt-get install git cmake ninja-build -y
RUN apt-get install wget -y

# GCC/Clang
RUN apt-get install --reinstall ca-certificates -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository --update ppa:ubuntu-toolchain-r/test
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
RUN apt-get install ccache -y
RUN apt-get install gcc-11 g++-11 -y

# clickhouse src
RUN git clone --recursive https://github.com/ClickHouse/ClickHouse.git \
 && ls -F contrib | sed  "s/$/.git/g" | sed "s/^/contrib\//g" | xargs rm -rf \
 && rm -rf .git

#RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
#RUN tar -xvf clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
#RUN mkdir -p ClickHouse/build && cd ClickHouse/build \
#  &&  cmake .. -DCMAKE_CXX_COMPILER=/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/clang++  -DCMAKE_C_COMPILER=/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/clang \
#  && ninja

