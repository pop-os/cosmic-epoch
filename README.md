# COSMIC Desktop

Currently an incomplete **pre-alpha**. Testing instructions below for various distributions.


## Components of COSMIC Desktop
* [cosmic-applets](https://github.com/silverhadch/cosmic-applets)
* [cosmic-applibrary](https://github.com/pop-os/cosmic-applibrary)
* [cosmic-bg](https://github.com/pop-os/cosmic-bg)
* [cosmic-comp](https://github.com/pop-os/cosmic-comp)
* [cosmic-edit](https://github.com/pop-os/cosmic-edit)
* [cosmic-files](https://github.com/pop-os/cosmic-files)
* [cosmic-greeter](https://github.com/silverhadch/cosmic-greeter)
* [cosmic-icons](https://github.com/pop-os/cosmic-icons)
* [cosmic-launcher](https://github.com/pop-os/cosmic-launcher)
* [cosmic-notifications](https://github.com/pop-os/cosmic-notifications)
* [cosmic-osd](https://github.com/pop-os/cosmic-osd)
* [cosmic-panel](https://github.com/pop-os/cosmic-panel)
* [cosmic-randr](https://github.com/pop-os/cosmic-randr)
* [cosmic-screenshot](https://github.com/pop-os/cosmic-screenshot)
* [cosmic-session](https://github.com/pop-os/cosmic-session)
* [cosmic-settings](https://github.com/pop-os/cosmic-settings)
* [cosmic-settings-daemon](https://github.com/pop-os/cosmic-settings-daemon)
* [cosmic-store](https://github.com/pop-os/cosmic-store)
* [cosmic-term](https://github.com/pop-os/cosmic-term)
* [cosmic-theme-editor](https://github.com/pop-os/cosmic-theme-editor)
* [cosmic-workspaces-epoch](https://github.com/pop-os/cosmic-workspaces-epoch)
* [xdg-desktop-portal-cosmic](https://github.com/pop-os/xdg-desktop-portal-cosmic)
* [pop-launcher](https://github.com/pop-os/launcher)

### COSMIC libraries/crates

* [cosmic-protocols](https://github.com/pop-os/cosmic-protocols)
* [cosmic-text](https://github.com/pop-os/cosmic-text)
* [cosmic-theme](https://github.com/pop-os/cosmic-theme)
* [cosmic-time](https://github.com/pop-os/cosmic-time)
* [libcosmic](https://github.com/pop-os/libcosmic)

## Setup on distributions without packaging of cosmic components

The COSMIC desktop environment requires a few dependencies:
(This list does not try to be exhaustive, but rather tries to provide a decent starting point. For detailed instructions, check out the individual projects):

- [just](https://github.com/casey/just)
- rustc
- libwayland
- mesa (or third-party libEGL/libGL implementations, though interfacing with mesa's libglvnd is generally recommended).
- libseat
- libxkbcommon
- libinput
- udev
- dbus

optionally (though the build-system might currently require these libraries):
- libsystem
- libpulse
- pop-launcher
- libexpat1
- libfontconfig
- libfreetype
- lld
- cargo
- libgbm-dev
- libclang-dev
- libpipewire-0.3-dev

Note: `libfontconfig`, `libfreetype`, and `lld` are packages specific to Linux distributions. You may need to find the equivalent version for your distribution if you are not using Pop!_OS.


### Testing

The easiest way to test COSMIC DE currently is by building a systemd system extension (see `man systemd-sysext`).

```
git clone --recurse-submodules https://github.com/pop-os/cosmic-epoch
cd cosmic-epoch
just sysext
```

This will create a system-extension called `cosmic-sysext`, that you can move (without renaming!) into e.g. `/var/lib/extensions`.
After starting systemd-sysext.service (`sudo systemctl enable --now systemd-sysext`) and refreshing (`sudo systemd-sysext refresh`) or rebooting,
*COSMIC* will be an available option in your favorite display manager.

If you have SELinux enabled (e.g. on Fedora), the installed extension won't have the correct labels applied.
To test COSMIC, you can temporarily disable it and restart `gdm` (note that this will close your running programs).

```shell
sudo setenforce 0
sudo systemctl restart gdm
```

**Note**: An extension created this way will be linked against specific libraries on your system and will not work on other distributions.
It also requires the previously mentioned libraries/dependencies at runtime to be installed in your system (the system extension does not carry these libraries).

**Read-Only Filesystem**: If you're not on an immutable distro you may notice that `/usr/` and `/opt/` are read-only.
this is caused by `systemd-sysext` being enabled, when you are done testing you can disable `systemd-sysext` (`sudo systemctl disable --now systemd-sysext`)

It is thus no proper method for long term deployment.

### Packaging

COSMIC DE is packaged for Pop!_OS. For reference, look at the `debian` folders in the projects repositories.
These and the `justfile` inside this repository may be used as references on how to package COSMIC DE, though no backwards-compatibility guarantees are provided at this stage.

### Versioning

COSMIC DE is very much still work-in-progress and thus does not follow a versioning scheme so far.
We do our best to keep the referenced submodule commits in this repository building and working together, as a consequence they might not contain the latest updates and features from these repositories (yet).

Notes on versioning and packaging all these components together properly will be added at a later stage once COSMIC DE gets its first release.


## Installing on Arch Linux
Installing via the preferred AUR helper is possible the usual way, e.g.:
`paru -S cosmic-session-git` or `yay -S cosmic-session-git`

Important: Git LFS which is used in cosmic-greeter-git won't build since git lfs in makepkg on Arch Linux is not directly supported. This Issue can be resolved with using the build tool 'makepkg-git-lfs-proto'
from the AUR ('yay -S makepkg-git-lfs-proto'). 
This tool then should be used when building.

There are 2 ways:
1. You configure makepkg to use the tool on git lfs on its own.
Add these variables to '/etc/makepkg.conf':
'BUILDPKG=makepkg-git-lfs-proto
BUILDMODULE=git-lfs'
Then it will permanetly use the tool on all git lfs operations on your Arch System.

Or

2. You replace the PKGBUILD file on a AUR-Helper Version of the cosmic-greeter-git.
It will ask for manuell Intervention.
'yay -S cosmic-greeter-git'
Then change Directory to the cloned Repository.
'cd cosmic-greeter-git'
And replace the PKGBUILD with the one Quackdoc made: https://github.com/Quackdoc/pkgbuild-scripts/blob/Master/cosmic-epoch/cosmic-greeter-git/PKGBUILD
After that you can build the cosmic-greeter-git with:
'makepkg -si'
You can then continue regulary with the AUR Helper at the Beginning of this Install for Arch.

Then log out, click on your user, and a sprocket at the bottom right shows an additional entry alongside your desktop environments. Change to COSMIC and proceed with log in.
For a more detailed discussion, consider the [relevant section in the Arch wiki](https://wiki.archlinux.org/title/COSMIC).


## Contact
- [Mattermost](https://chat.pop-os.org/)
- [Twitter](https://twitter.com/pop_os_official)
- [Instagram](https://www.instagram.com/pop_os_official/)
