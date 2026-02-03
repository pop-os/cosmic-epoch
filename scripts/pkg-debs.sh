#!/usr/bin/env bash

set -Eeuo pipefail

vars() {
    REPO_DIR="$(pwd)"
    BUILD_DIR="${BUILD_DIR:-${REPO_DIR}}/_build/debs_$(date +%s)"
    PROJECTS=()
    export JOBS="${JOBS:-$(nproc)}"
    export DEB_BUILD_OPTIONS="parallel=${JOBS}"
}

main() {
    setup_dir_env
    cd "${_SCRIPT_DIR}/.."
    vars

    echo "BUILD_DIR: ${BUILD_DIR}"
    echo "JOBS: ${JOBS}"

    rm -rf "${BUILD_DIR}"
    mkdir -p "${BUILD_DIR}"

    discover_projects
    build_projects
}

setup_dir_env() {
    _WORKING_DIR="$(pwd)"
    local dir="$(dirname "${BASH_SOURCE[0]}")"
    _SCRIPT_DIR="$(cd "$dir/" && pwd)"
}

discover_projects() {
  echo "=== Discovering debian subprojects.."
  mapfile -t PROJECTS < <(
    cd "$REPO_DIR"
    find . -maxdepth 2 -type d -name debian -printf '%h\n' | sed 's|^\./||' | sort
  )
  [ "${#PROJECTS[@]}" -gt 0 ] || { echo "No debian/ directories found"; exit 1; }
  for p in "${PROJECTS[@]}"; do echo " - $p"; done
}

build_projects() {
  for p in "${PROJECTS[@]}"; do
    echo "=== Building: $p"
    pushd "$REPO_DIR/$p" >/dev/null
    dpkg_build
    popd >/dev/null
    mv -f *.deb *.buildinfo *.changes "$BUILD_DIR" || true
  done
}

dpkg_build() {
    sudo mk-build-deps -i -r debian/control || true
    dpkg-buildpackage -b -d -uc -us -j"${JOBS}"
}

main "$@"
