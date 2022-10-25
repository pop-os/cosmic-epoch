# Cosmic Desktop

Currently an incomplete **pre-alpha**.

## Components of Cosmic Desktop
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

The Cosmic desktop environment requires a few dependencies:
(This list does not try to be exhaustive, but rather tries to provide a decent starting point. For detailed instructions check out the individual projects):

- [just](https://github.com/casey/just)
- rust
- libwayland
- mesa (or third-party libEGL/libGL implementations, though interfacing with mesa's libglvnd is generally recommended).
- libseat
- libxkbcommon
- libinput
- udev
- gtk4
- dbus

optionally (though the build-system might currently require these libraries):
- libsystemd
- libpulse
- pop-launcher

### Testing

The easiest way to test Cosmic DE currently is by building a systemd system extension (see `man systemd-sysext`).
```
git clone --recurse-submodules https://github.com/pop-os/cosmic-epoch
cd cosmic-epoch
just sysext
```

This will create a system-extension inside `cosmic-sysext`, that you can move (without renaming!) into e.g. `/var/lib/extensions`.
After starting systemd-sysext.service (`sudo systemctl enable --now systemd-sysext`) and refreshing (`sudo systemd-sysext refresh`) or rebooting
*COSMIC* will be an available option in your favorite display manager.

**Note**: An extension created this way will be linked against specific libraries on your system and will not work on other distributions.
It also requires the previously mentioned libraries/dependencies at runtime to be installed in your system (the system extension does not carry these libraries).

It is thus no proper method for long term deployment.

### Experimental X Support

With [opam installed](https://opam.ocaml.org/doc/Install.html) X support using wayland-proxy-virtwl can be optionally enabled during installation. When building, use `just x=1 sysext` and after refreshing with `sudo systemd-sysext refresh`, run
```
systemctl --user daemon-reload
systemctl --user enable --now wayland-proxy-virtwl
```
### Packaging

Cosmic DE is packaged for Pop!_OS for reference look at the `debian` folders in the projects repositories.
These and the `justfile` inside this repository may be used as references on how to package Cosmic DE, though no backwards-compatibility guarantees are provided at this stage.

### Versioning

Cosmic DE is very much still work-in-progress and thus does not follow a versioning scheme so far.
We do our best to keep the referenced submodule commits in this repository building and working together, as a consequence they might not contain the latest updates and features from these repositories (yet).

Notes on versioning and packaging all these components together properly will be added at a later stage once Cosmic DE gets its first release.
