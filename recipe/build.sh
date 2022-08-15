#!/usr/bin/env bash

set -ex

MESON_ARGS="${MESON_ARGS:---prefix=${PREFIX} --libdir=lib}"

meson setup \
  _build \
  ${MESON_ARGS} \
  --buildtype=release \
  -Dpython_version=${PYTHON}
meson compile -C _build
meson install -C _build --no-rebuild
