# Borrowed from https://github.com/chendaniely/docker-renv/blob/main/Dockerfile
FROM rocker/rstudio:latest

# Set renv library path inside the container
ENV RENV_PATHS_ROOT=/home/rstudio/renv

# Ensure the renv library directory exists
RUN mkdir -p /home/rstudio/renv

# Set working directory
WORKDIR /home/rstudio

# Copy analysis to the docker container
COPY analysis.qmd analysis.qmd

# Set working directory
WORKDIR /home/rstudio/renv

# Copy only renv.lock and activate.R first to cache dependency installation
COPY renv.lock renv.lock
COPY renv/activate.R renv/activate.R

# Install renv and restore packages
RUN R -e "install.packages('renv', repos='https://cloud.r-project.org')"
RUN R -e "renv::restore()"

EXPOSE 8787