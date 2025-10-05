set dotenv-load
just := just_executable()
make := `which make`

build:
    mkdir -p build
    {{ just }} cosmic-applets/build-release
    {{ just }} cosmic-applibrary/build-release
    {{ just }} cosmic-bg/build-release
    {{ make }} -C cosmic-comp all
    {{ just }} cosmic-edit/build-release
    {{ just }} cosmic-files/build-release
    {{ just }} cosmic-greeter/build-release
    {{ just }} cosmic-idle/build-release
    {{ just }} cosmic-initial-setup/build-release
    {{ just }} cosmic-launcher/build-release
    {{ just }} cosmic-notifications/build-release
    {{ make }} -C cosmic-osd all
    {{ just }} cosmic-panel/build-release
    {{ just }} cosmic-player/build-release
    {{ just }} cosmic-randr/build-release
    {{ just }} cosmic-screenshot/build-release
    {{ just }} cosmic-settings/build-release
    {{ make }} -C cosmic-settings-daemon all
    {{ just }} cosmic-session/all
    {{ just }} cosmic-store/build-release
    {{ just }} cosmic-term/build-release
    {{ make }} -C cosmic-wallpapers all
    {{ make }} -C cosmic-workspaces-epoch all
    {{ just }} pop-launcher/build-release
    {{ make }} -C xdg-desktop-portal-cosmic all

install rootdir="" prefix="/usr/local": build
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-applets/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-applibrary/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-bg/install
    {{ make }} -C cosmic-comp install DESTDIR={{rootdir}} prefix={{prefix}}
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-edit/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-files/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-greeter/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-icons/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-idle/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-initial-setup/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-launcher/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-notifications/install
    {{ make }} -C cosmic-osd install DESTDIR={{rootdir}} prefix={{prefix}}
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-panel/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-player/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-randr/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-screenshot/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-settings/install
    {{ make }} -C cosmic-settings-daemon install DESTDIR={{rootdir}} prefix={{prefix}}
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-session/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-store/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} cosmic-term/install
    {{ make }} -C cosmic-wallpapers install DESTDIR={{rootdir}} prefix={{prefix}}
    {{ make }} -C cosmic-workspaces-epoch install DESTDIR={{rootdir}} prefix={{prefix}}
    {{ just }} rootdir={{rootdir}} pop-launcher/install
    {{ make }} -C xdg-desktop-portal-cosmic install DESTDIR={{rootdir}} prefix={{prefix}}

_mkdir dir:
   mkdir -p dir

sysext dir=(invocation_directory() / "cosmic-sysext") version=("nightly-" + `git rev-parse --short HEAD`): (_mkdir dir) (install dir "/usr")
    #!/usr/bin/env sh
    mkdir -p {{dir}}/usr/lib/extension-release.d/
    cat >{{dir}}/usr/lib/extension-release.d/extension-release.cosmic-sysext <<EOF
    NAME="Cosmic DE"
    VERSION={{version}}
    $(cat /etc/os-release | grep '^ID=')
    $(cat /etc/os-release | grep '^VERSION_ID=')
    EOF
    echo "Done"

clean:
    rm -rf cosmic-sysext
    rm -rf cosmic-applets/target
    rm -rf cosmic-applibrary/target
    rm -rf cosmic-bg/target
    rm -rf cosmic-comp/target
    rm -rf cosmic-edit/target
    {{ just }} cosmic-files/clean
    rm -rf cosmic-greeter/target
    {{ just }} cosmic-idle/clean
    {{ just }} cosmic-initial-setup/clean
    rm -rf cosmic-launcher/target
    rm -rf cosmic-panel/target
    rm -rf cosmic-player/target
    rm -rf cosmic-notifications/target
    rm -rf cosmic-osd/target
    rm -rf cosmic-randr/target
    rm -rf cosmic-screenshot/target
    rm -rf cosmic-settings/target
    rm -rf cosmic-settings-daemon/target
    rm -rf cosmic-session/target
    {{ just }} cosmic-store/clean
    {{ just }} cosmic-term/clean
    {{ make }} -C cosmic-wallpapers clean
    rm -rf cosmic-workspaces-epoch/target
    {{ just }} pop-launcher/clean
    rm -rf xdg-desktop-portal-cosmic/target
