# --------------------------------------------------
# Base Stage: Install system dependencies & restore R packages via renv
# --------------------------------------------------

# Borrowed from https://github.com/chendaniely/docker-renv/blob/main/Dockerfile
FROM rocker/verse:4.4.3 AS base

# Install required system dependencies
RUN apt-get update && apt-get install -y \
  # For HTTP requests, XML parsing, and secure connections
  libcurl4-openssl-dev \
  libssl-dev \
  libxml2-dev \
  libgit2-dev \
  pkg-config \
  \
  # For text rendering (used by ggplot2 and other graphics libs)
  libharfbuzz-dev \
  libfribidi-dev \
  \
  # For image rendering and graphics
  libfontconfig1-dev \
  libfreetype6-dev \
  libpng-dev \
  libtiff5-dev \
  libjpeg-dev \
  \
  # For compressed data reading/writing
  libbz2-dev \
  zlib1g-dev \
  \
  # Clean up
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /home/rstudio/

# Copy only renv.lock and activate.R first to cache dependency 
# installation
COPY renv.lock renv.lock
COPY renv/activate.R renv/activate.R

# Set default cache location
RUN mkdir -p renv/cache
ENV RENV_PATHS_CACHE=renv/cache

# Install and restore packages using renv
RUN R -e "install.packages('renv', repos = 'https://cloud.r-project.org'); \
          renv::consent(provided = TRUE); \
          renv::activate()"
RUN R -e "renv::restore()"

# Ensure permissions are open for mounted volumes in later steps
RUN chmod -R 777 renv/
RUN chmod -R 777 renv.lock

# --------------------------------------------------
# Final Stage: Setup runtime environment
# --------------------------------------------------
FROM rocker/verse:4.4.3

# Set working directory inside the container
WORKDIR /home/rstudio/

# Switch to rstudio user temporarily to install Quarto and TinyTeX
USER rstudio
RUN quarto install tinytex
# Switch back to root for file copy and permission setup
USER root

# Copy everything from the base stage and the rest of the local project into 
# the container
COPY --from=base /home/rstudio .
COPY . .

# Make sure the data directory is writable
RUN chmod -R 777 data

# Expose RStudio Server's default port
EXPOSE 8787
