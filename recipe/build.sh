#!/usr/bin/env bash

set -ex

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" != "1" ]]; then
  MESON_ARGS=${MESON_ARGS:---prefix=${PREFIX} --libdir=lib}
else
  cat > pkgconfig.ini <<EOF
[binaries]
pkgconfig = '$BUILD_PREFIX/bin/pkg-config'
EOF
  MESON_ARGS="${MESON_ARGS:---prefix=${PREFIX} --libdir=lib} --cross-file pkgconfig.ini"
fi

meson setup _build \
  ${MESON_ARGS} \
  --buildtype=release \
  --warnlevel=0 \
  -Dpython_version=$PYTHON

meson compile -C _build
meson install -C _build --no-rebuild
