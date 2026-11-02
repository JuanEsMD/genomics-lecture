FROM docker.io/mambaorg/micromamba:2.10.0-debian13-slim
USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends libgl1 \
    && rm -rf /var/lib/apt/lists/*
USER $MAMBA_USER
COPY --chown=$MAMBA_USER:$MAMBA_USER genome.yml /tmp/genome.yml
RUN micromamba install --yes --name base --file /tmp/genome.yml \
    && micromamba clean --all --yes \
    && rm /tmp/genome.yml

LABEL devcontainer.metadata='[{"remoteUser":"mambauser","containerEnv":{"XDG_RUNTIME_DIR":"/home/mambauser/.xdg_runtime"},"postCreateCommand":"mkdir -p /home/mambauser/.xdg_runtime && chmod 0700 /home/mambauser/.xdg_runtime"}]'
