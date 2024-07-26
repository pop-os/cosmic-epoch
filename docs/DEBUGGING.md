Debugging COSMIC
================

An assortment of useful tools and settings for debugging COSMIC.

## Logs
Cosmic-comp, cosmic-panel, and other components log to `stderr`, as well as journald (if present).

## Wayland and X11 Protocols

Run clients with `WAYLAND_DEBUG=1` to see what wayland calls are made. `xtrace -n <command>` can be used to see what X calls an X11 client is making.

## XWayland

A tool like `xprop` can be used to determine if an application is running in XWayland. If `xprop` is unable to select a window, it is a native Wayland window.

## Performance

`sudo perf top` can be used to see what functions, across all processes, are using the most CPU time. The `-p` argument can be used to restrict this to a single process. The output is more useful for executables with debug symbols.

`cosmic-comp` integrates Tracy for profiling. It can be built with `cargo build --features profile-with-tracy --profile fastdebug`, then the Tracy client can connect from the same system or a different one

## Graphics drivers
`eglinfo` and `vulkaninfo` indicate what graphics cards and drivers are in use for hardware-accelerated rendering.

On systems with NVIDIA graphics, `nvidia-smi` has information about the GPU and driver.

## DRM
The Linux DRM subsystem handles graphics cards and display controllers.

`drm_info` prints information about the outputs, planes, etc. associated with each GPU and their properties. The output of this command can be useful for understanding display related issues.

https://gitlab.freedesktop.org/wlroots/wlroots/-/wikis/DRM-Debugging documents how to configure DRM to enable additional logging, which can be useful for understanding some DRM driver issues.

## Frozen desktop

If the desktop is frozen and `ctrl+alt+f*` don't work to change to a TTY, [the magic SysRq key](https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html) with `r` can be used to swich input in raw mode, so the kernel will handle the tty switch key binding. /etc/sysctl.conf` or `/etc/sysctl.d` may need to be edited first to set `kernel.sysrq=1` or another value that allows this command.

It is also possible to connect over `ssh` from another computer.

Then `pidof cosmic-comp` can be used to get the PID of the compositor. Then it is possible to investigate further with tools like `gdb`, using `sudo gdb` then `attach <pid>`.
