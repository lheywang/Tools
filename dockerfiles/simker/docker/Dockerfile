# ================================================================================================
# Container init
# ================================================================================================
# Base image
FROM ubuntu:24.04
WORKDIR /work

# Updating OS to the latest versions
RUN apt-get update && apt-get upgrade -y

# Install software build dependencies
RUN apt-get install -y \
    cmake \
    make \
    texinfo \
    automake \
    autoconf \
    gcc \
    g++ \
    build-essential \
    git \
    wget \
    ccache

# Verilator deps : 
RUN apt-get install -y \
    help2man \
    perl \
    python3 \
    libfl2 \
    libfl-dev \
    zlib1g \
    zlib1g-dev \
    libsystemc \
    libsystemc-dev \
    perl-doc \
    z3 \
    mold \
    libgoogle-perftools-dev \
    numactl \
    flex \
    bison \
    python3-distro

# GHDL deps : 
RUN apt-get install -y \
    gnat \
    libgmp-dev \
    libmpfr-dev \
    libmpc-dev

# NGSPICE deps
RUN apt-get install -y \
    libtool \
    libxaw7-dev \
    libreadline-dev

# XSCHEM deps :
RUN apt-get install -y \
    mawk \
    libx11-dev \
    libxpm-dev \
    flex \
    bison \
    libcairo2-dev \
    xcb \
    libxrender-dev

# GAW3 deps :
RUN apt-get install -y \
    libgtk-4-dev

# GTKWave deps :
RUN apt-get install -y \
    meson \
    gperf \
    flex \
    desktop-file-utils \
    libgtk-3-dev \
    tcl-dev \
    tk-dev \
    libbz2-dev \
    libjudy-dev \
    liblzma-dev \
    libgirepository1.0-dev

# Creating future folders
RUN mkdir /work/build_tmp

# Creating output folders
RUN mkdir /tools
RUN mkdir /tools/verilator
RUN mkdir /tools/ghdl
RUN mkdir /tools/ngspice
RUN mkdir /tools/xschem
RUN mkdir /tools/gaw3
RUN mkdir /tools/gtkwave

# ================================================================================================
# Tools installation
# ================================================================================================
# Fetching the different elements : 
WORKDIR /work/build_tmp
RUN git clone --recursive -j 4 https://github.com/verilator/verilator.git verilator
RUN git clone --recursive -j 4 https://github.com/ghdl/ghdl.git ghdl
RUN git clone --recursive -j 4 https://git.code.sf.net/p/ngspice/ngspice ngspice
RUN git clone --recursive -j 4 https://github.com/StefanSchippers/xschem.git xschem
RUN git clone --recursive -j 4 https://github.com/StefanSchippers/xschem-gaw.git gaw3
RUN git clone --recursive -j 4 https://github.com/gtkwave/gtkwave.git gtkwave

# Get sources of GCC (for GHDL build)
WORKDIR /work/res
RUN wget https://ftp.fu-berlin.de/unix/languages/gcc/releases/gcc-12.5.0/gcc-12.5.0.tar.gz
RUN mkdir gcc
RUN tar -xf *.tar.gz -C gcc --strip-components=1

# Compiling the different tools :
# ---------------------
# Verilator
# ---------------------
WORKDIR /work/build_tmp/verilator

RUN unset VERILATOR_ROOT

RUN git pull && git checkout stable
RUN autoconf
RUN ./configure --prefix /tools/verilator
RUN make -j8
RUN make test
RUN make install

# ---------------------
# GHDL
# ---------------------
WORKDIR /work/build_tmp/ghdl
RUN mkdir build 
WORKDIR /work/build_tmp/ghdl/build

RUN ../configure --with-gcc=/work/res/gcc --prefix=/tools/ghdl
RUN make copy-sources

RUN mkdir gcc-objs
WORKDIR /work/build_tmp/ghdl/build/gcc-objs

RUN /work/res/gcc/configure \
    --prefix=/tools/ghdl \
    --enable-languages=c,vhdl \
    --disable-bootstrap \
    --disable-lto \
    --disable-multilib \
    --disable-libssp \
    --disable-libgomp \
    --disable-libquadmath
RUN make -j8 && make install

WORKDIR /work/build_tmp/ghdl/build
RUN make ghdllib
RUN make install

# ---------------------
# NGSPICE
# ---------------------
WORKDIR /work/build_tmp/ngspice

RUN ./autogen.sh
RUN mkdir debug

WORKDIR /work/build_tmp/ngspice/debug

RUN ../configure --with-x --enable-cider --prefix=/tools/ngspice
RUN make -j8
RUN make install

# ---------------------
# XSCHEM
# ---------------------
WORKDIR /work/build_tmp/xschem

RUN ./configure 
RUN make -j8
RUN make install DESTDIR=/tools/xschem

# ---------------------
# GAW3
# ---------------------
WORKDIR /work/build_tmp/gaw3

RUN ./configure --prefix=/tools/gaw3
RUN make -j8
RUN make install

# ---------------------
# GTKWAVE
# ---------------------
WORKDIR /work/build_tmp/gtkwave

RUN meson setup build --prefix=/tools/gtkwave
WORKDIR /work/build_tmp/gtkwave/build
RUN meson install

# ================================================================================================
# Display configuration
# ================================================================================================
# Installing deps 
RUN apt-get install -y \
    xauth \
    x11-apps \
    libxext6 \
    libxrender1 \
    libxft2

# Set default to DISPLAY
ENV DISPLAY=:0

# ================================================================================================
# Finishing up things
# ================================================================================================
# Cleaning up the build folders 
RUN rm -rf /work/build_tmp

# Setting up workir
WORKDIR /work

# Setting up the PATH
ENV PATH="/tools/gaw3/bin:${PATH}"
ENV PATH="/tools/ghdl/bin:${PATH}"
ENV PATH="/tools/gtkwave/bin:${PATH}"
ENV PATH="/tools/ngspice/bin:${PATH}"
ENV PATH="/tools/verilator/bin:${PATH}"
ENV PATH="/tools/xschem/usr/local/bin:${PATH}"

# Adding a variable to make sure xschem can start
ENV XSCHEM_SHAREDIR="/tools/xschem/usr/local/share/xschem"

# Setting CMD / ENTRYPOINT
CMD ["/bin/sh"]
