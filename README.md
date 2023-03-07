# COSMIC Desktop

Currently an incomplete **pre-alpha**.

## Components of COSMIC Desktop
* [cosmic-applets](https://github.com/pop-os/cosmic-applets)
* [cosmic-applibrary](https://github.com/pop-os/cosmic-applibrary)
* [cosmic-comp](https://github.com/pop-os/cosmic-comp)
* [cosmic-launcher](https://github.com/pop-os/cosmic-launcher)
* [cosmic-osd](https://github.com/pop-os/cosmic-osd)
* [comsic-panel](https://github.com/pop-os/cosmic-panel)
* [cosmic-protocols](https://github.com/pop-os/cosmic-protocols)
* [cosmic-settings](https://github.com/pop-os/cosmic-settings)
* [cosmic-settings-daemon](https://github.com/pop-os/cosmic-settings-daemon)
* [cosmic-session](https://github.com/pop-os/cosmic-session)
* [cosmic-text](https://github.com/pop-os/cosmic-text)
* [cosmic-text-editor](https://github.com/pop-os/cosmic-text-editor)
* [cosmic-theme](https://github.com/pop-os/cosmic-theme)
* [cosmic-theme-editor](https://github.com/pop-os/cosmic-theme-editor)
* [cosmic-time](https://github.com/pop-os/cosmic-time)
* [cosmic-workspaces-epoch](https://github.com/pop-os/cosmic-workspaces-epoch)
* [libcosmic](https://github.com/pop-os/libcosmic)
* [xdg-desktop-portal-cosmic](https://github.com/pop-os/xdg-desktop-portal-cosmic)

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

### Installing on Pop!_OS
COSMIC DE is in heavy development and not ready for issue reports. Currently, GUIs are incomplete and don't match designs, desktop settings aren't available and bugs are obvious and known. You're seeing the sausage be made. Most configuration is currently in text files and would be familiar to i3/Sway users. A call for testing will be announced when the project is ready for reports. With that out of the way, feel free to jump in and have fun.

#### Enable Wayland
`sudo nano /etc/gdm/custom.conf`

Change to true
WayalandEnable=true

#### Install COSMIC
`sudo apt install cosmic-*`

After logging out, click on your user and there will be a sprocket at the bottom right. Change the setting to COSMIC. Proceed to log in.

#### Configuring COSMIC DE
This is basic configuration to get you started. See individual projects repos above for details.

Access cosmic-launcher with `Super+/`. This will eventually be moved to `Super` alone.

##### COSMIC COMP
COSMIC Comp is the compositor for COSMIC DE. Its config file is located at `/etc/cosmic-comp/config.ron`. Enable tiling by setting `tiling_enabled: true,` at the bottom of the file.

##### Screenshots
`sudo apt install ksnip qtwayland5`

Add `(modifiers: [], key: "Print"): Spawn("ksnip -t"),` to `/etc/cosmic-comp/config.ron`. The screenshot will open in a separate window for cropping and saving.

##### Panel Configuration
```shell
mkdir ~/.config/cosmic-panel
cd ~/.config/cosmic-panel
wget https://github.com/pop-os/cosmic-panel/blob/master_jammy/cosmic-panel-config/config.ron
nano config.ron
```
To apply configuration changes, open System Monitor, find the cosmic-panel process and click End Process. The panel should restart automatically. If not, you may have an invalid option or syntax error. Correct the error and launch the panel with `cosmic-panel </dev/null &>/dev/null &`.

##### Setting a Background
```shell
mkdir ~/.config/com.system76.CosmicBg
cd ~/.config/com.system76.CosmicBg
nano config.ron
```

Example file
```
(
    backgrounds: [
        (
            output: All,
            source: Path("/home/carl/Pictures/Wallpaper/pexels-eberhard-grossgasteiger-443446.jpg"),
            filter_by_theme: false,
            rotation_frequency: 3600,
        ),
    ],
)
```

##### WebGL on NVIDIA
WebGL on NVIDIA is currently [broken](https://github.com/pop-os/cosmic-comp/issues/84) but will work in Google Chrome using software rendering.

`flatpak install com.google.Chrome`

Change flags to enable wayland and dark mode.
chrome://flags/#ozone-platform-hint (Wayland)
chrome://flags/#enable-force-dark (Enabled)
chrome://flags/#enable-webrtc-pipewire-capturer (Enabled)

## Contact
- [Mattermost](https://chat.pop-os.org/)
- [Twitter](https://twitter.com/pop_os_official)
- [Instagram](https://www.instagram.com/pop_os_official/)
