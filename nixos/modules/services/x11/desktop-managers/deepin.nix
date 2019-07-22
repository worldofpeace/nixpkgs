{ config, lib, pkgs, ... }:

with lib;

let

  xcfg = config.services.xserver;
  cfg = xcfg.desktopManager.deepin;

in

{
  options = {

    services.xserver.desktopManager.deepin.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the Deepin Desktop Environment";
    };

  };


  config = mkIf (xcfg.enable && cfg.enable) {

    services.xserver.displayManager.extraSessionFilePackages = [ pkgs.deepin.startdde ];
    services.xserver.desktopManager.default = mkForce "deepin";

    hardware.bluetooth.enable = mkDefault true;
    hardware.pulseaudio.enable = mkDefault true;
    security.polkit.enable = true;
    services.accounts-daemon.enable = true;
    services.bamf.enable = true;
    services.dbus.packages = [ pkgs.gnome3.dconf ];
    services.deepin.core.enable = true;
    services.gnome3.at-spi2-core.enable = true;
    services.gnome3.glib-networking.enable = true;
    services.gnome3.gnome-keyring.enable = true;
    services.gnome3.gvfs.enable = true;
    services.udisks2.enable = true;
    services.upower.enable = config.powerManagement.enable;
    services.xserver.libinput.enable = mkDefault true;
    services.xserver.updateDbusEnvironment = true;

    networking.networkmanager.enable = true;

    networking.networkmanager.basePackages = {
      inherit (pkgs) networkmanager modemmanager wpa_supplicant;
      inherit (pkgs.gnome3) networkmanager-openvpn networkmanager-vpnc
      networkmanager-openconnect networkmanager-fortisslvpn
      networkmanager-iodine networkmanager-l2tp;
    };

    fonts.fonts = with pkgs; [ noto-fonts ];

    environment.systemPackages = with pkgs; [
      deepin.dde-calendar
      deepin.dde-daemon
      (deepin.dde-dock.override { plugins = [ deepin.dde-file-manager ]; })
      deepin.dde-file-manager
      deepin.dde-launcher
      deepin.dde-polkit-agent
      deepin.dde-session-ui
      deepin.deepin-desktop-base
      deepin.deepin-gtk-theme
      deepin.deepin-icon-theme
      deepin.deepin-image-viewer
      deepin.deepin-metacity
      deepin.deepin-movie-reborn
      deepin.deepin-mutter
      deepin.deepin-screenshot
      deepin.deepin-shortcut-viewer
      deepin.deepin-sound-theme
      deepin.deepin-terminal
      deepin.deepin-wallpapers
      deepin.deepin-wm
      deepin.dpa-ext-gnomekeyring
      deepin.qt5dxcb-plugin
      deepin.qt5integration
      deepin.startdde
    ];

    environment.variables.DDE_POLKIT_PLUGINS_DIRS = [ "${config.system.path}/lib/polkit-1-dde/plugins" ];

    environment.variables.GIO_EXTRA_MODULES = [
      "${lib.getLib pkgs.gnome3.dconf}/lib/gio/modules"
      "${pkgs.gnome3.gvfs}/lib/gio/modules"
    ];

    # Link some extra directories in /run/current-system/sw/share
    environment.pathsToLink = [
      "/lib/polkit-1-dde/plugins"
      "/share"
    ];
  };
}
