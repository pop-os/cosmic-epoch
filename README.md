# COSMIC Desktop

[COSMIC](https://system76.com/cosmic) is a desktop environment offering performance, efficiency, and personalization to empower a wide variety of use cases.

## Components of COSMIC Desktop
* [cosmic-applets](https://github.com/pop-os/cosmic-applets)
* [cosmic-applibrary](https://github.com/pop-os/cosmic-applibrary)
* [cosmic-bg](https://github.com/pop-os/cosmic-bg)
* [cosmic-comp](https://github.com/pop-os/cosmic-comp)
* [cosmic-edit](https://github.com/pop-os/cosmic-edit)
* [cosmic-files](https://github.com/pop-os/cosmic-files)
* [cosmic-greeter](https://github.com/pop-os/cosmic-greeter)
* [cosmic-icons](https://github.com/pop-os/cosmic-icons)
* [cosmic-idle](https://github.com/pop-os/cosmic-idle)
* [cosmic-initial-setup](https://github.com/pop-os/cosmic-initial-setup)
* [cosmic-launcher](https://github.com/pop-os/cosmic-launcher)
* [cosmic-notifications](https://github.com/pop-os/cosmic-notifications)
* [cosmic-osd](https://github.com/pop-os/cosmic-osd)
* [cosmic-panel](https://github.com/pop-os/cosmic-panel)
* [cosmic-player](https://github.com/pop-os/cosmic-player)
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

### COSMIC toolkit for apps and applets

* [libcosmic](https://github.com/pop-os/libcosmic)

## Installing on Pop!\_OS

### Pop!\_OS 24.04

COSMIC DE's first release (Epoch 1) is included in Pop!\_OS 24.04. There are two ways to get the 24.04 release:

- Install it from the [latest release ISO](https://system76.com/cosmic/).
- Upgrade an existing Pop!\_OS 22.04 installation using the following command: `pop-upgrade release upgrade -f`
    - If you experience problems during the upgrade, please open an issue in the [pop-upgrade GitHub repository](https://github.com/pop-os/upgrade) or join the [Pop!\_OS Mattermost chat server](https://chat.pop-os.org) for assistance.

COSMIC users, including Pop!_OS users, are welcome to join the [Pop!\_OS Mattermost chat server](https://chat.pop-os.org) to receive news about development. Join the [COSMIC Epoch channel](https://chat.pop-os.org/pop-os/channels/cosmic-epoch) for COSMIC user discussion, or the [Development channel](https://chat.pop-os.org/pop-os/channels/development) for developer-oriented discussion.

### Pop!\_OS 22.04

Due to dependency requirements, **COSMIC Epoch is no longer receiving updates on Pop!\_OS 22.04 LTS.** It's no longer recommended to test COSMIC Epoch on Pop!\_OS 22.04 because the latest bug fixes and features are only available on newer distributions such as Pop!\_OS 24.04.

Individual COSMIC applications work in the default GNOME session of Pop!\_OS 22.04. You can install individual COSMIC applications using the following command:

```
sudo apt install cosmic-edit cosmic-files cosmic-player cosmic-store cosmic-term
```

#### Old Release on 22.04

An **older release** of the COSMIC Epoch desktop environment alpha is still available on Pop!\_OS 22.04 LTS. If you encounter bugs while testing COSMIC Epoch on Pop!\_OS 22.04, please check if they exist in Pop!\_OS 24.04 before reporting them. You can install the older release on 22.04 with these instructions:

##### Enable Wayland

`sudo nano /etc/gdm3/custom.conf`

Change `WaylandEnable` to `true`:
```
WaylandEnable=true
```

Reboot for this change to take effect.

##### Update udev rules for NVIDIA users

```shell
sudo nano /usr/lib/udev/rules.d/61-gdm.rules
```

Look for `LABEL="gdm_prefer_xorg"` and `LABEL="gdm_disable_wayland"`. Add `#` to the `RUN` statements so they look like this:

```
LABEL="gdm_prefer_xorg"
#RUN+="/usr/libexec/gdm-runtime-config set daemon PreferredDisplayServer xorg"
GOTO="gdm_end"

LABEL="gdm_disable_wayland"
#RUN+="/usr/libexec/gdm-runtime-config set daemon WaylandEnable false"
GOTO="gdm_end"
```

Restart gdm

```shell
sudo systemctl restart gdm
```

##### Install COSMIC

`sudo apt install cosmic-session`

After logging out, click on your user and there will be a sprocket at the bottom right. Change the setting to COSMIC. Proceed to log in.

## Installing on Arch Linux
Install via [cosmic-session](https://archlinux.org/packages/extra/x86_64/cosmic-session/) or the [cosmic](https://archlinux.org/groups/x86_64/cosmic/) group, e.g.:
`pacman -S cosmic-session` or `pacman -S cosmic`

Then log out, click on your user, and a sprocket at the bottom right shows an additional entry alongside your desktop environments. Change to COSMIC and proceed with log in.
For a more detailed discussion, consider the [relevant section in the Arch wiki](https://wiki.archlinux.org/title/COSMIC).

## Installing on Fedora Linux

COSMIC can be installed from the built-in repositories on Fedora 41+:

```
sudo dnf install @cosmic-desktop-environment
```

Alternatively, for more up-to-date COSMIC packages (but less quality control), you can use the nightly COPR builds:

```
sudo dnf copr enable ryanabx/cosmic-epoch && sudo dnf install cosmic-desktop
```

After installing, log out, click on your user, and use the sprocket in the bottom right to select the COSMIC desktop environment before logging in.
For more information, check the [Fedora Wiki COSMIC SIG page](https://fedoraproject.org/wiki/SIGs/COSMIC) or the [COPR page](https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/).

## Installing on NixOS
The COSMIC module on NixOS can be enabled by adding the following lines to
your NixOS configuration file (`configuration.nix` or in your Flake):
```nix
{
  # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;
}
```

While some packages like `cosmic-session` might be present in prior versions,
the modules that add full support for COSMIC were added in **NixOS 25.05**.

You can find more details on the [NixOS Wiki](https://wiki.nixos.org/wiki/COSMIC).


## Installing on openSUSE tumbleweed
Cosmic can be installed by adding X11:COSMIC:Factory repo with opi.
```
opi patterns-cosmic
```
Select X11:COSMIC:Factory, after installing keep the repo.

Then log out, click on your user, and a sprocket at the bottom right shows an additional entry alongside your desktop environments. Change to COSMIC and proceed with log in.
For further information, you may check the [OBS page](https://build.opensuse.org/project/show/X11:COSMIC:Factory).

## Installing on Gentoo Linux
COSMIC can be installed on Gentoo via a custom overlay. Add the overlay using your preferred overlay manager (such as eselect), and then install the desktop environment:

`eselect repository add cosmic-overlay git https://github.com/fsvm88/cosmic-overlay.git`

Next, install the COSMIC desktop environment and its associated themes:

`emerge cosmic-meta pop-theme-meta`

Then log out, click on your user, and a sprocket at the bottom right shows an additional entry alongside your desktop environments. Change to COSMIC and proceed with log in.
For further information, you may check the [Gentoo Wiki](https://wiki.gentoo.org/wiki/COSMIC) or [Overlay Repository](https://github.com/fsvm88/cosmic-overlay).

## Setup on distributions without packaging of COSMIC components

The COSMIC desktop environment requires a few dependencies. The rustc and just packages of your distro may be too old, so we recommend installing rustc and cargo with rustup, and installing just with cargo.
(This list does not try to be exhaustive, but rather tries to provide a decent starting point. For detailed instructions, check out the individual projects):

- [just](https://github.com/casey/just)
- rustc
- cargo
- c compiler (cc)
- make
- git
- libwayland
- mesa (or third-party libEGL/libGL implementations, though interfacing with mesa's libglvnd is generally recommended).
- libseat
- libxkbcommon
- libinput
- udev
- dbus
- libdisplay-info-dev
- libgstreamer1.0-dev
- libgstreamer-plugins-base1.0-dev

optionally (though the build-system might currently require these libraries):
- libsystem
- libpulse
- libexpat1
- libfontconfig
- libfreetype
- lld
- libgbm-dev
- libclang-dev
- libpipewire-0.3-dev

Note: `libfontconfig`, `libfreetype`, and `lld` are packages specific to Linux distributions. You may need to find the equivalent version for your distribution if you are not using Pop!_OS.

The required ones can be installed with:
```
sudo apt install -y \
  build-essential \
  dbus \
  git \
  libdbus-1-dev \
  libdisplay-info-dev \
  libflatpak-dev \
  libglvnd-dev \
  libgstreamer-plugins-base1.0-dev \
  libgstreamer1.0-dev \
  libinput-dev \
  libpam0g-dev \
  libpixman-1-dev \
  libseat-dev \
  libssl-dev \
  libwayland-dev \
  libxkbcommon-dev \
  rustup \
  udev

rustup toolchain install stable
cargo install just
```

and the optional ones with:
```
sudo apt install -y \
  libclang-dev \
  libexpat1-dev \
  libfontconfig-dev \
  libfreetype-dev \
  libgbm-dev \
  libpipewire-0.3-dev \
  libpulse-dev \
  libsystemd-dev \
  lld \
  mold
```

They can be installed all at once with:
```
sudo apt install -y \
  build-essential \
  dbus \
  git \
  libclang-dev \
  libdbus-1-dev \
  libdisplay-info-dev \
  libexpat1-dev \
  libflatpak-dev \
  libfontconfig-dev \
  libfreetype-dev \
  libgbm-dev \
  libglvnd-dev \
  libgstreamer-plugins-base1.0-dev \
  libgstreamer1.0-dev \
  libinput-dev \
  libpam0g-dev \
  libpipewire-0.3-dev \
  libpixman-1-dev \
  libpulse-dev \
  libseat-dev \
  libssl-dev \
  libsystemd-dev \
  libwayland-dev \
  libxkbcommon-dev \
  lld \
  mold \
  rustup \
  udev

rustup toolchain install stable
cargo install just
```

### Testing

The easiest way to test COSMIC DE currently is by building a systemd system extension (see `man systemd-sysext`).

```
git clone --recurse-submodules https://github.com/pop-os/cosmic-epoch
cd cosmic-epoch
just sysext
```

This will create a system-extension called `cosmic-sysext`, which you can move (without renaming!) into e.g. `/var/lib/extensions`.
After starting systemd-sysext.service (`sudo systemctl enable --now systemd-sysext`) and refreshing (`sudo systemd-sysext refresh`) or rebooting,
COSMIC will be an available option in your favorite display manager.

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

It is thus not a proper method for long term deployment.

### Packaging

COSMIC DE is packaged for Pop!_OS. For reference, look at the `debian` folders in the projects repositories.
These and the `justfile` inside this repository may be used as references on how to package COSMIC DE, though no backwards-compatibility guarantees are provided at this stage.

### Versioning

COSMIC DE is a work in progress with many moving pieces.
We do our best to keep the referenced submodule commits in this repository building and working together; as a consequence, they might not contain the latest updates and features from these repositories (yet).

The commits corresponding with the current release are tagged `epoch-X.Y.Z`, where `X` is the major release and the last two numbers denote incremental minor releases. (During development of new major versions, an additional `-alpha.Y.Z` or `-beta.Y.Z` may be appended.)

COSMIC Epoch version numbers are mainly for the benefit of non-Pop!_OS distributions; Pop!_OS uses its own build system, and typically receives updates to individual submodules before they're tagged as part of a COSMIC Epoch release.

## Translating

To submit translations for COSMIC in your language, please use Weblate: https://hosted.weblate.org/projects/pop-os/ 

## Contact
- [Mattermost](https://chat.pop-os.org/)
- [Twitter](https://twitter.com/pop_os_official)
- [Instagram](https://www.instagram.com/pop_os_official/)
