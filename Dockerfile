FROM sagebionetworks/rstudio:4.1.0

LABEL maintainer="thomas.schaffter@protonmail.com"
LABEL description="Exploration of the 2014 i2b2 PHI annotation dataset"

# Create conda environments
COPY conda /tmp/conda
RUN conda init bash \
    && conda env create -f /tmp/conda/i2b2-phi-dataset/environment.yml \
    && rm -fr /tmp/conda \
    # Fix libssl issue that affects conda env used with reticulate
    && cp /usr/lib/x86_64-linux-gnu/libssl.so.1.1 \
        /opt/miniconda/envs/i2b2-phi-dataset/lib/libssl.so.1.1 \
    && conda activate base || true \
    && echo "conda activate i2b2-phi-dataset" >> ~/.bashrc

# Install R dependencies
COPY renv.lock /tmp/renv.lock
RUN install2.r --error renv \
    && R -e "renv::consent(provided=TRUE)" \
    && R -e "renv::restore(lockfile='/tmp/renv.lock')" \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds /tmp/renv.lock \
    && R -e "extrafont::font_import(prompt=FALSE)"
