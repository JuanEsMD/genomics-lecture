FROM mambaorg/micromamba:2.10.0-debian13-slim
USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends libgl1 \
    && rm -rf /var/lib/apt/lists/*
USER $MAMBA_USER
COPY --chown=$MAMBA_USER:$MAMBA_USER genome.yml /tmp/genome.yml
RUN micromamba install --yes --name base --file /tmp/genome.yml \
    && micromamba clean --all --yes \
    && rm /tmp/genome.yml
