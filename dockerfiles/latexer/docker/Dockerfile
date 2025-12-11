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

# Creating future folders
RUN mkdir /work/build_tmp

# Creating output folders
RUN mkdir /tools
RUN mkdir /tools/inkscape
RUN mkdir /tools/ghostscript
RUN mkdir /tools/texlive
RUN mkdir /tools/evince

# ================================================================================================
# Tools installation
# ================================================================================================
# Fetching the different elements : 
WORKDIR /work/build_tmp
RUN git clone --recursive -j 4 https://gitlab.com/inkscape/inkscape.git inkscape
RUN git clone --recursive -j 4 https://github.com/ArtifexSoftware/ghostpdl.git ghostscript
RUN git clone --recursive -j 4 https://github.com/GNOME/evince.git evince
RUN git clone --recursive -j 4 git://git.texlive.info/CTAN texlive

# Compiling the different tools :
# ---------------------
# Inkscape
# ---------------------

# ---------------------
# Ghostscript
# ---------------------

# ---------------------
# Evince
# ---------------------

# ---------------------
# Texlive
# ---------------------

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
# RUN rm -rf /work/build_tmp

# Setting up workir
WORKDIR /work

# Setting up the PATH
ENV PATH="/tools/inkscape/bin:${PATH}"
ENV PATH="/tools/ghostscript/bin:${PATH}"
ENV PATH="/tools/evince/bin:${PATH}"
ENV PATH="/tools/texlive/bin:${PATH}"

# Setting CMD / ENTRYPOINT
CMD ["/bin/sh"]