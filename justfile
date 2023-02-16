set dotenv-load
just := just_executable()
make := `which make`
meson := `which meson`

_meson_build dir:
    -rm -rf {{dir}}_build
    mkdir -p {{dir}}_build
    {{ meson }} setup {{dir}}_build {{dir}} --prefix=/usr -Dvendor=false
    {{ meson }} compile -C {{dir}}_build

_meson_install dir destdir:
    {{ meson }} install -C {{dir}}_build --destdir={{destdir}}

build:
    mkdir -p build
    {{ just }} cosmic-applets/build
    {{ just }} _meson_build cosmic-applibrary
    {{ just }} cosmic-bg/build-release
    {{ make }} -C cosmic-comp all
    {{ just }} cosmic-launcher/build-release
    {{ make }} -C cosmic-osd all
    {{ make }} -C cosmic-panel all
    {{ just }} cosmic-settings/build-release
    {{ make }} -C cosmic-settings-daemon all
    {{ just }} cosmic-session/all
    {{ make }} -C xdg-desktop-portal-cosmic all

sysext dir=`echo $(pwd)/cosmic-sysext` version=("nightly-" + `git rev-parse --short HEAD`): build && (_extension_release dir version)
    mkdir -p {{dir}}/usr/lib/extension-release.d/
    {{ just }} rootdir={{dir}} cosmic-applets/install
    {{ just }} _meson_install cosmic-applibrary {{dir}}
    {{ just }} rootdir={{dir}} cosmic-bg/install
    {{ make }} -C cosmic-comp install DESTDIR={{dir}}
    {{ just }} rootdir={{dir}} cosmic-launcher/install
    {{ make }} -C cosmic-osd install DESTDIR={{dir}} prefix=/usr
    {{ make }} -C cosmic-panel install DESTDIR={{dir}} prefix=/usr
    {{ just }} rootdir={{dir}} cosmic-launcher/install
    {{ make }} -C cosmic-settings-daemon install DESTDIR={{dir}} prefix=/usr
    {{ make }} -C xdg-desktop-portal-cosmic install DESTDIR={{dir}} prefix=/usr
    {{ just }} rootdir={{dir}} cosmic-session/install
_extension_release dir version:
    #!/usr/bin/env sh
    cat >{{dir}}/usr/lib/extension-release.d/extension-release.cosmic-sysext <<EOF
    NAME="Cosmic DE"
    VERSION={{version}}
    $(cat /etc/os-release | grep '^ID=')
    $(cat /etc/os-release | grep '^VERSION_ID=')
    EOF
    echo "Done"

clean:
    rm -rf cosmic-applets/target
    rm -rf cosmic-applibrary/target
    rm -rf cosmic-bg/target
    rm -rf cosmic-comp/target
    rm -rf cosmic-launcher/target
    rm -rf cosmic-panel/target
    rm -rf cosmic-osd/target
    rm -rf cosmic-settings/target
    rm -rf cosmic-settings-daemon/target
    rm -rf cosmic-session/target
    rm -rf xdg-desktop-portal-cosmic/target
