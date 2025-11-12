#!/usr/bin/env bash

set -Eeuo pipefail

vars() {
    NAME=cosmic-desktop-git
    DESC_SHORT="Cosmic Desktop"
    VERSION=$(date +%Y%m%d)-$(git rev-parse --short HEAD)-1
    ARCH=amd64
    MAINTAINER="Nobody <nobody@localhost>"
    DESC_LONG="${DESC_SHORT} from git"
    PKG_FULL=${NAME}_${VERSION}_${ARCH}

    BUILD_DIR=$(pwd)/_build/
    export DESTDIR=${BUILD_DIR}/${PKG_FULL}
}

main() {
    setup_dir_env
    cd "${_SCRIPT_DIR}/.."
    vars

    echo "Version: ${VERSION}"
    echo "DESTDIR: ${DESTDIR}"

    rm -rf ${DESTDIR}
    mkdir -p ${DESTDIR}/DEBIAN/

    build
    package_deb
}

setup_dir_env() {
    _WORKING_DIR="$(pwd)"
    local dir="$(dirname "${BASH_SOURCE[0]}")"
    _SCRIPT_DIR="$(cd "$dir/" && pwd)"
}

build() {
    just install ${DESTDIR} /usr
}

package_deb() {
    cat <<-END >${DESTDIR}/DEBIAN/control
Package: ${NAME}
Version: ${VERSION}
Architecture: ${ARCH}
Maintainer: ${MAINTAINER}
Description: ${DESC_SHORT}
    ${DESC_LONG}
END
    dpkg-deb --build --root-owner-group ${DESTDIR}
}

main "$@"
