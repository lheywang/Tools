# ================================================================================================
# Container init
# ================================================================================================
# Base image
FROM texlive/texlive:TL2024-historic
WORKDIR /work

# Updating OS to the latest versions
RUN apt-get update && apt-get upgrade -y

# Install software build dependencies
RUN apt-get install -y \
    git \
    inkscape graphviz gnuplot \
    python3 python3-pip \
    ghostscript \
    evince \
    wget2

# Locking TLMGR to the correct version (remove a warning for cross year updates)
RUN tlmgr option repository https://ftp.tu-chemnitz.de/pub/tug/historic/systems/texlive/2024/tlnet-final
RUN tlmgr update --self

# ================================================================================================
# MANAGING TEMPLATES
# ================================================================================================
# Create target directories
RUN mkdir -p /tools/templates
RUN mkdir -p /tools/scripts

# Import data into the image
COPY scripts /tools/scripts

# Make the scripts executables
RUN chmod +x /tools/scripts/package-update.sh
RUN chmod +x /tools/scripts/template-update.sh

# Fetching and updating packages : 
WORKDIR /tools/templates
RUN sh /tools/scripts/template-update.sh
RUN sh /tools/scripts/package-update.sh

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
RUN rm -rf /var/lib/apt/lists/*

# Setting up workir
WORKDIR /work

# Updating path (including scripts)
ENV PATH="/tools/tcreator/:${PATH}"
ENV PATH="/tools/scripts/:${PATH}"

# Setting CMD / ENTRYPOINT
CMD ["/bin/sh"]