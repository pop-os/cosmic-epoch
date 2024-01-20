# COSMIC Desktop

Currently an incomplete **pre-alpha**. Testing instructions below for various distributions.


## Components of COSMIC Desktop
* [cosmic-applets](https://github.com/pop-os/cosmic-applets)
* [cosmic-applibrary](https://github.com/pop-os/cosmic-applibrary)
* [cosmic-bg](https://github.com/pop-os/cosmic-bg)
* [cosmic-comp](https://github.com/pop-os/cosmic-comp)
* [cosmic-edit](https://github.com/pop-os/cosmic-edit)
* [cosmic-files](https://github.com/pop-os/cosmic-files)
* [cosmic-greeter](https://github.com/pop-os/cosmic-greeter)
* [cosmic-icons](https://github.com/pop-os/cosmic-icons)
* [cosmic-launcher](https://github.com/pop-os/cosmic-launcher)
* [cosmic-notifications](https://github.com/pop-os/cosmic-notifications)
* [cosmic-osd](https://github.com/pop-os/cosmic-osd)
* [cosmic-panel](https://github.com/pop-os/cosmic-panel)
* [cosmic-randr](https://github.com/pop-os/cosmic-randr)
* [cosmic-session](https://github.com/pop-os/cosmic-session)
* [cosmic-settings-daemon](https://github.com/pop-os/cosmic-settings-daemon)
* [cosmic-settings](https://github.com/pop-os/cosmic-settings)
* [cosmic-store](https://github.com/pop-os/cosmic-store)
* [cosmic-term](https://github.com/pop-os/cosmic-term)
* [cosmic-theme-editor](https://github.com/pop-os/cosmic-theme-editor)
* [cosmic-workspaces-epoch](https://github.com/pop-os/cosmic-workspaces-epoch)
* [xdg-desktop-portal-cosmic](https://github.com/pop-os/xdg-desktop-portal-cosmic)

### COSMIC libraries/crates

* [cosmic-protocols](https://github.com/pop-os/cosmic-protocols)
* [cosmic-text](https://github.com/pop-os/cosmic-text)
* [cosmic-theme](https://github.com/pop-os/cosmic-theme)
* [cosmic-time](https://github.com/pop-os/cosmic-time)
* [libcosmic](https://github.com/pop-os/libcosmic)

## Setup on distributions without packaging of cosmic components

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
- cargo
- libgbm-dev
- libclang-dev
- libpipewire-0.3-dev

Note: `libfontconfig`, `libfreetype`, and `lld` are packages specific to Linux distributions. You may need to find the equivalent version for your distribution if you are not using Pop!_OS.

The required ones can be installed with:
```
sudo apt install just rustc libglvnd-dev libwayland-dev libseat-dev libxkbcommon-dev libinput-dev libgtk-4-1 udev dbus libdbus-1-dev -y
```

and the optional ones with:
```
sudo apt install libsystemd-dev libpulse-dev pop-launcher libexpat1-dev libfontconfig-dev libfreetype-dev lld cargo libgbm-dev libclang-dev libpipewire-0.3-dev -y
```

They can be installed all at once with:
```
sudo apt install just rustc libglvnd-dev libwayland-dev libseat-dev libxkbcommon-dev libinput-dev libgtk-4-1 udev dbus libdbus-1-dev libsystemd-dev libpulse-dev pop-launcher libexpat1-dev libfontconfig-dev libfreetype-dev lld cargo libgbm-dev libclang-dev libpipewire-0.3-dev -y
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

**Read-Only Filesystem**: If you're not on an immutable distro you may notice that `/usr/` and `/opt/` are read-only.
this is caused by `systemd-sysext` being enabled, when you are done testing you can disable `systemd-sysext` (`sudo systemctl disable --now systemd-sysext`)

It is thus no proper method for long term deployment.

### Packaging

COSMIC DE is packaged for Pop!_OS. For reference look at the `debian` folders in the projects repositories.
These and the `justfile` inside this repository may be used as references on how to package COSMIC DE, though no backwards-compatibility guarantees are provided at this stage.

### Versioning

COSMIC DE is very much still work-in-progress and thus does not follow a versioning scheme so far.
We do our best to keep the referenced submodule commits in this repository building and working together, as a consequence they might not contain the latest updates and features from these repositories (yet).

Notes on versioning and packaging all these components together properly will be added at a later stage once COSMIC DE gets its first release.

## Installing on Pop!_OS
COSMIC DE is in heavy development and not ready for issue reports. Currently, GUIs are incomplete and don't match designs, desktop settings aren't available and bugs are obvious and known. You're seeing the sausage be made. Most configuration is currently in text files and would be familiar to i3/Sway users. A call for testing will be announced when the project is ready for reports. With that out of the way, feel free to jump in and have fun.

#### Enable Wayland
`sudo nano /etc/gdm3/custom.conf`

Change to true
WaylandEnable=true

Reboot for this change to take effect.

#### Disable SELinux

If you have SELinux enabled (e.g. on Fedora), the installed extension won't have the correct labels applied.
To test COSMIC, you can temporarily disable it and restart `gdm` (note that this will close your running programs).

```shell
sudo setenforce 0
sudo systemctl restart gdm
```

#### Install COSMIC
`sudo apt install cosmic-*`

After logging out, click on your user and there will be a sprocket at the bottom right. Change the setting to COSMIC. Proceed to log in.

## Installing on Arch Linux
Installing via the preferred AUR helper is possible the usual way, e.g.:
`paru -S cosmic-epoch-git`

Then log out, click on your user, and a sprocket at the bottom right shows an additional entry alongside your desktop environments. Change to COSMIC and proceed with log in.
For a more detailled discussion consider the [relevant section in the Arch wiki](https://wiki.archlinux.org/title/COSMIC).

## Configuring COSMIC DE
This is basic configuration to get you started. See individual projects repos above for details.

Access cosmic-launcher with `Super` and cosmic-applibrary with `Super+a`.

##### COSMIC COMP
COSMIC Comp is the compositor for COSMIC DE. Its config file is located at `/etc/cosmic-comp/config.ron`. You can enable tiling by default by setting `tiling_enabled: true,` at the bottom of the file. Super+y will toggle tiling per workspace.

```shell
sudo mkdir /etc/cosmic-comp
sudo cp cosmic-comp/config.ron /etc/cosmic-comp
sudo -e /etc/cosmic-comp/config.ron
```

###### Scaling
Changing the scaling of the DE can be done in this file:

```shell
nano ~/.local/state/cosmic-comp/outputs.ron
```

##### Screenshots
`sudo apt install ksnip qtwayland5`

Add `(modifiers: [], key: "Print"): Spawn("ksnip -t"),` to `/etc/cosmic-comp/config.ron`. The screenshot will open in a separate window for cropping and saving.

##### Panel Configuration
Panels can now be configured in the COSMIC Settings app under Desktop > Desktop and Panel > Panel/Dock

##### Desktop Wallpaper
Wallpaper can now be configured in the COSMIC Settings app under Desktop > Wallpapers

##### WebGL on NVIDIA
WebGL on NVIDIA is currently [broken](https://github.com/pop-os/cosmic-comp/issues/84) but will work in Google Chrome using software rendering.

`flatpak install com.google.Chrome`

## Contact
- [Mattermost](https://chat.pop-os.org/)
- [Twitter](https://twitter.com/pop_os_official)
- [Instagram](https://www.instagram.com/pop_os_official/)
