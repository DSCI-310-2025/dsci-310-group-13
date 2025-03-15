# Borrowed from https://github.com/chendaniely/docker-renv/blob/main/Dockerfile
FROM rocker/rstudio:4.4.3

# Set renv library path inside the container
ENV RENV_PATHS_ROOT=/home/rstudio/renv

# Ensure the renv library directory exists
RUN mkdir -p /home/rstudio/renv

# Set working directory
WORKDIR /home/rstudio/renv

# Copy only renv.lock and activate.R first to cache dependency installation
COPY renv.lock renv.lock
COPY renv/activate.R renv/activate.R

# Install required system dependencies
RUN apt-get update && apt-get install -y \
  libcurl4-openssl-dev \
  libssl-dev \
  libxml2-dev \
  libharfbuzz-dev \
  libfribidi-dev \
  libgit2-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libpng-dev \
  libtiff5-dev \
  libjpeg-dev \
  libbz2-dev \
  zlib1g-dev \
  pkg-config

# Install renv and restore packages
RUN R -e "install.packages('renv', repos='https://cloud.r-project.org')"
RUN R -e "renv::restore()"

EXPOSE 8787
