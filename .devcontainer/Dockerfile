# ---- build stage: create conda env, then drop caches/headers/static libs ----
FROM docker.io/mambaorg/micromamba:2.10.0-debian13-slim AS build
COPY --chown=$MAMBA_USER:$MAMBA_USER genome.yml /tmp/genome.yml
# sysroot/kernel-headers (pulled by k8) and ruby/yaggo (pulled by mummer4)
# are build-time only; remove them without touching their dependents.
# entrez-direct and the perl modules it needs come in with blast (a unicycler
# dependency), but unicycler only calls makeblastdb/tblastn, so drop them too.
# The perl interpreter itself stays: mummerplot and dnadiff are perl scripts,
# and they only use what the base perl package ships.
RUN micromamba install --yes --name base --file /tmp/genome.yml \
    && micromamba remove --yes --name base --force \
         sysroot_linux-64 kernel-headers_linux-64 yaggo ruby entrez-direct \
         $(ls /opt/conda/conda-meta/*.json | sed 's#.*/##; s#\.json$##; s#-[^-]*-[^-]*$##' | grep '^perl-') \
    && micromamba clean --all --force-pkgs-dirs --yes \
    && rm -rf /opt/conda/pkgs /opt/conda/include \
              /opt/conda/share/doc /opt/conda/share/man /opt/conda/share/info /opt/conda/share/gir-1.0 \
    && find /opt/conda -name '*.a' -delete

# ---- runtime stage ----
FROM docker.io/mambaorg/micromamba:2.10.0-debian13-slim
USER root
# Bandage / gnuplot from Debian: conda versions pull in full Qt5 + LLVM (~1GB).
# Mesa (+LLVM, z3) is not needed for Bandage's rendering; drop it
# (QT_XCB_GL_INTEGRATION=none below silences the resulting GLX warnings).
RUN apt-get update \
    && apt-get install -y --no-install-recommends bandage gnuplot-nox \
    && dpkg --purge --force-depends libgl1-mesa-dri mesa-libgallium libllvm19 libz3-4 \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build --chown=$MAMBA_USER:$MAMBA_USER /opt/conda /opt/conda
USER $MAMBA_USER

LABEL devcontainer.metadata='[{"remoteUser":"mambauser","containerEnv":{"XDG_RUNTIME_DIR":"/home/mambauser/.xdg_runtime","QT_XCB_GL_INTEGRATION":"none"},"postCreateCommand":"mkdir -p /home/mambauser/.xdg_runtime && chmod 0700 /home/mambauser/.xdg_runtime"}]'
