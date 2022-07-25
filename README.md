# KDE with i3 for Plasma 5.25+

This script creates a new xsession entry which boots KDE Plasma with the i3 window manager.

## Installation
- Install KDE Plasma and i3
- Run `install.sh`

## i3 config
By default, `~/.config/i3/config-kde` is used as the config file. \
If not found during installation, the script will copy `~/.config/i3/config` or run the wizard. \
This can be changed in `~/.config/systemd/user/plasma-i3.service` (after install).

## Further configuration
See [this guide](https://github.com/heckelson/i3-and-kde-plasma) (skip the creating service section).
