#!/bin/sh
cd ~/.dotfiles/_backup/gnome
dconf dump /org/gnome/mutter/keybindings/ > org_gnome_mutter_keybindings.dump
dconf dump /org/gnome/shell/keybindings/ > org_gnome_shell_keybindings.dump
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > org_gnome_settings-daemon_plugins_media-keys.dump
dconf dump /org/gnome/desktop/interface/ > org_gnome_desktop_interface.dump
dconf dump /org/gnome/desktop/peripherals/touchpad/ > org_gnome_desktop_peripherals_touchpad.dump
dconf dump /org/gnome/desktop/wm/keybindings/ > org_gnome_desktop_wm_keybindings.dump
dconf dump /org/gnome/terminal/ > org_gnome_terminal.dump
dconf dump /org/gnome/shell/extensions/dash-to-panel/ > org_gnome_shell_extensions_dash-to-panel.dump
dconf dump /org/gnome/shell/extensions/nothing-to-say/ > org_gnome_shell_extensions_nothing-to-say.dump
dconf dump /com/github/amezin/ddterm/ > com_github_amezin_ddterm.dump
dconf dump /apps/guake/ > apps_guake.dump
dconf dump /org/gnome/shell/extensions/tiling-assistant/ > org_gnome_shell_extensions_tiling-assistant.dump
dconf dump /org/gnome/shell/extensions/date-menu-formatter/ > org_gnome_shell_extensions_date-menu-formatter.dump
dconf dump /org/gnome/shell/extensions/desktop-cube/ > org_gnome_shell_extensions_desktop-cube.dump
dconf dump /org/gnome/shell/extensions/clipboard-indicator/ > org_gnome_shell_extensions_clipboard-indicator.dump
dconf dump /org/gnome/shell/extensions/status-area-horizontal-spacing/ > org_gnome_shell_extensions_status-area-horizontal-spacing.dump
dconf dump /org/gnome/shell/extensions/space-bar/ > org_gnome_shell_extensions_space-bar.dump
dconf dump /org/gnome/pomodoro/preferences/ > org_gnome_pomodoro.dump
