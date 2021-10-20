#!/bin/sh
dconf load /apps/guake/ < ~/.dotfiles/_backup/gnome/apps_guake.dump
dconf load /org/gnome/desktop/interface/ < ~/.dotfiles/_backup/gnome/org_gnome_desktop_interface.dump
dconf load /org/gnome/desktop/wm/keybindings/ < ~/.dotfiles/_backup/gnome/org_gnome_desktop_wm_keybindings.dump
dconf load /org/gnome/mutter/keybindings/ < ~/.dotfiles/_backup/gnome/org_gnome_mutter_keybindings.dump
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < ~/.dotfiles/_backup/gnome/org_gnome_settings-daemon_plugins_media-keys.dump
dconf load /org/gnome/terminal/ < ~/.dotfiles/_backup/gnome/org_gnome_terminal.dump
dconf load /org/gnome/shell/extensions/dash-to-panel/ < ~/.dotfiles/_backup/gnome/org_gnome_shell_extensions_dash-to-panel.dump
dconf load /org/gnome/shell/extensions/nothing-to-say/ < ~/.dotfiles/_backup/gnome/org_gnome_shell_extensions_nothing-to-say.dump
dconf load /org/gnome/shell/keybindings/ < ~/.dotfiles/_backup/gnome/org_gnome_shell_keybindings.dump
dconf load /org/gnome/desktop/peripherals/touchpad/ < ~/.dotfiles/_backup/gnome/org_gnome_desktop_peripherals_touchpad.dump
dconf load /com/github/amezin/ddterm/ < ~/.dotfiles/_backup/gnome/com_github_amezin_ddterm.dump
