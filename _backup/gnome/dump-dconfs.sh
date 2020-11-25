#!/bin/sh
dconf dump /org/gnome/mutter/keybindings/ > org_gnome_mutter_keybindings.dump
dconf dump /org/gnome/shell/keybindings/ > org_gnome_shell_keybindings.dump
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > org_gnome_settings-daemon_plugins_media-keys.dump
