# ---- build stage: create conda env, then drop caches/headers/static libs ----
FROM docker.io/mambaorg/micromamba:2.10.0-debian13-slim AS build
COPY --chown=$MAMBA_USER:$MAMBA_USER genome.yml /tmp/genome.yml
RUN micromamba install --yes --name base --file /tmp/genome.yml \
    && micromamba clean --all --force-pkgs-dirs --yes \
    && rm -rf /opt/conda/pkgs /opt/conda/include \
              /opt/conda/share/doc /opt/conda/share/man /opt/conda/share/info /opt/conda/share/gir-1.0 \
    && find /opt/conda -name '*.a' -delete

# ---- runtime stage ----
FROM docker.io/mambaorg/micromamba:2.10.0-debian13-slim
USER root
# Bandage / gnuplot from Debian: conda versions pull in full Qt5 + LLVM (~1GB)
RUN apt-get update \
    && apt-get install -y --no-install-recommends bandage gnuplot-nox \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build --chown=$MAMBA_USER:$MAMBA_USER /opt/conda /opt/conda
USER $MAMBA_USER

LABEL devcontainer.metadata='[{"remoteUser":"mambauser","containerEnv":{"XDG_RUNTIME_DIR":"/home/mambauser/.xdg_runtime"},"postCreateCommand":"mkdir -p /home/mambauser/.xdg_runtime && chmod 0700 /home/mambauser/.xdg_runtime"}]'
