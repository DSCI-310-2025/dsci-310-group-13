# Borrowed from https://github.com/chendaniely/docker-renv/blob/main/Dockerfile
FROM rocker/rstudio:4.4.3

# Set renv library path inside the container
ENV RENV_PATHS_ROOT=/home/rstudio/renv

# Set working directory
WORKDIR /home/rstudio/

# Copy only renv.lock and activate.R first to cache dependency installation
COPY renv.lock renv.lock
COPY renv /home/rstudio/renv
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
  pkg-config \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install renv and restore packages
RUN R -e "install.packages('renv', repos='https://cloud.r-project.org')"
RUN R -e "renv::consent(provided = TRUE)"
RUN R -e "renv::activate()"
RUN R -e "renv::restore()"
# install tinytex for building pdfs
RUN R -e "tinytex::install_tinytex()"

COPY . .

EXPOSE 8787
