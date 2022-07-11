just := just_executable()
make := `which make`

build:
    {{ just }} cosmic-applets/all
    {{ just }} cosmic-applibrary/all
    {{ make }} -C cosmic-comp all
    {{ just }} cosmic-launcher/all
    {{ make }} -C cosmic-panel all
    {{ just }} cosmic-session/all
    {{ make }} -C simple-wrapper all

sysext dir=`echo $(pwd)/cosmic-sysext` version=("nightly-" + `git rev-parse --short HEAD`): build && (_extension_release dir version)
    @mkdir -p {{dir}}/usr/lib/extension-release.d/
    {{ just }} rootdir={{dir}} cosmic-applets/install
    {{ just }} rootdir={{dir}} cosmic-applibrary/install
    {{ make }} -C cosmic-comp install DESTDIR={{dir}}
    {{ just }} rootdir={{dir}} cosmic-launcher/install
    {{ make }} -C cosmic-panel install DESTDIR={{dir}} prefix=/usr
    {{ just }} rootdir={{dir}} cosmic-session/install
    {{ make }} -C simple-wrapper install DESTDIR={{dir}} prefix=/usr

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
    rm -rf cosmic-comp/target
    rm -rf cosmic-launcher/target
    rm -rf cosmic-panel/target
    rm -rf cosmic-session/target
    rm -rf simple-wrapper/target
