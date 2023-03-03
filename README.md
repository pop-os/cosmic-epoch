# COSMIC Desktop

Currently an incomplete **pre-alpha**.

## Components of COSMIC Desktop
* [cosmic-applets](https://github.com/pop-os/cosmic-applets)
* [cosmic-applet-host](https://github.com/pop-os/cosmic-applet-host)
* [cosmic-applibrary](https://github.com/pop-os/cosmic-applibrary)
* [cosmic-comp](https://github.com/pop-os/cosmic-comp)
* [xdg-desktop-portal-cosmic](https://github.com/pop-os/xdg-desktop-portal-cosmic)
* [cosmic-launcher](https://github.com/pop-os/cosmic-launcher)
* [cosmic-osd](https://github.com/pop-os/cosmic-osd)
* [comsic-panel](https://github.com/pop-os/cosmic-panel)
* [cosmic-settings](https://github.com/pop-os/cosmic-settings)
* [cosmic-settings-daemon](https://github.com/pop-os/cosmic-settings-daemon)
* [cosmic-session](https://github.com/pop-os/cosmic-session)
* [cosmic-theme](https://github.com/pop-os/cosmic-theme)
* [cosmic-theme-editor](https://github.com/pop-os/cosmic-theme-editor)
* [libcosmic](https://github.com/pop-os/libcosmic)

## Setup

The COSMIC desktop environment requires a few dependencies:
(This list does not try to be exhaustive, but rather tries to provide a decent starting point. For detailed instructions check out the individual projects):

- [just](https://github.com/casey/just)
- rustc
- libwayland
- mesa (or third-party libEGL/libGL implementations, though interfacing with mesa's libglvnd is generally recommended).
- libseat
- libxkbcommon
- libinput
- libgtk
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

Note: `libfontconfig`, `libfreetype`, and `lld` are packages specific to Linux distributions. You may need to find the equivalent version for your distribution if you are not using Pop!_OS.

The required ones can be installed with:
```
sudo apt install just rustc libglvnd-dev libwayland-dev libseat-dev libxkbcommon-dev libinput-dev libgtk-4-1 udev dbus -y
```

and the optional ones with:
```
sudo apt install libsystemd-dev libpulse-dev pop-launcher libexpat1-dev libfontconfig-dev libfreetype-dev lld -y
```

They can be installed all at once with:
```
sudo apt install just rustc libglvnd-dev libwayland-dev libseat-dev libxkbcommon-dev libinput-dev libgtk-4-1 udev dbus libsystemd-dev libpulse-dev pop-launcher libexpat1-dev libfontconfig-dev libfreetype-dev lld -y
```
 
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

**Note**: An extension created this way will be linked against specific libraries on your system and will not work on other distributions.
It also requires the previously mentioned libraries/dependencies at runtime to be installed in your system (the system extension does not carry these libraries).

It is thus no proper method for long term deployment.

### Packaging

COSMIC DE is packaged for Pop!_OS. For reference look at the `debian` folders in the projects repositories.
These and the `justfile` inside this repository may be used as references on how to package COSMIC DE, though no backwards-compatibility guarantees are provided at this stage.

### Versioning

COSMIC DE is very much still work-in-progress and thus does not follow a versioning scheme so far.
We do our best to keep the referenced submodule commits in this repository building and working together, as a consequence they might not contain the latest updates and features from these repositories (yet).

Notes on versioning and packaging all these components together properly will be added at a later stage once COSMIC DE gets its first release.
