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

    #services.xserver.displayManager.extraSessionFilePackages = [ pkgs.deepin.startdde ];

    services.xserver.desktopManager.session = singleton {
      name = "deepin";
      start = ''
        exec ${pkgs.deepin.startdde}/sbin/startdde
      '';
    };

    services.deepin.core.enable = true;
    services.gnome3.gnome-keyring.enable = true;
    services.upower.enable = config.powerManagement.enable;
    programs.dconf.enable = true;
    networking.networkmanager.enable = true;

    fonts.fonts = with pkgs; [ noto-fonts ];

    environment.systemPackages = with pkgs; [
      deepin.dbus-factory
      deepin.dde-api
      deepin.dde-calendar
      deepin.dde-daemon
      (deepin.dde-dock.override { plugins = [ deepin.dde-file-manager ]; })
      deepin.dde-file-manager
      deepin.dde-launcher
      deepin.dde-network-utils
      deepin.dde-polkit-agent
      deepin.dde-qt-dbus-factory
      deepin.dde-session-ui
      deepin.deepin-anything
      deepin.deepin-desktop-base
      deepin.deepin-desktop-schemas
      deepin.deepin-gettext-tools
      deepin.deepin-gtk-theme
      deepin.deepin-icon-theme
      deepin.deepin-image-viewer
      deepin.deepin-menu
      deepin.deepin-metacity
      deepin.deepin-movie-reborn
      deepin.deepin-mutter
      deepin.deepin-screenshot
      deepin.deepin-shortcut-viewer
      deepin.deepin-sound-theme
      deepin.deepin-terminal
      deepin.deepin-turbo
      deepin.deepin-wallpapers
      deepin.deepin-wm
      deepin.dpa-ext-gnomekeyring
      deepin.dtkcore
      deepin.dtkwidget
      deepin.dtkwm
      deepin.go-dbus-factory
      deepin.go-dbus-generator
      deepin.go-gir-generator
      deepin.go-lib
      deepin.qt5dxcb-plugin
      deepin.qt5integration
      deepin.startdde
    ];

    environment.variables.DDE_POLKIT_PLUGINS_DIRS = [ "${config.system.path}/lib/polkit-1-dde/plugins" ];

    # Link some extra directories in /run/current-system/software/share
    environment.pathsToLink = [
      "/lib/polkit-1-dde/plugins"
      "/share"
    ];
  };
}
