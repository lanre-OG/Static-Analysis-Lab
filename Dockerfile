FROM ubuntu:16.10

RUN apt-get update &&  apt-get install  -y \
    llvm-3.6 clang-3.6  git \
    automake \
    build-essential \
    cmake \ 
    curl \
    doxygen \
    git \
    graphviz \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libboost-thread-dev \
    libbz2-dev \
    libopenmpi-dev \
    openmpi-bin \
    openmpi-common  \
    openssh-client \ 
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* 

ENV CMAKE_PREFIX_PATH=/opt/fftw-3.3.4:/opt/pfft-1.0.8-alpha:$CMAKE_PREFIX_PATH

RUN update-alternatives --install /usr/bin/clang   clang   /usr/bin/clang-3.6 999 \
 && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 999 \
 && update-alternatives --install /usr/bin/cc  cc  /usr/bin/clang-3.6 999 \
 && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-3.6 999

 
ENV CCACHE_DIR=/ccache
ENV CC="ccache clang" CXX="ccache clang++" SCA="ccache scan-build-3.6"

ENV PATH “$PATH:/usr/bin”

