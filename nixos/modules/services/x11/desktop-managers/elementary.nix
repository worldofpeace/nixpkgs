{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.xserver.desktopManager.elementary;

  nixos-gsettings-desktop-schemas = pkgs.runCommand "nixos-gsettings-desktop-schemas" {}
    ''
     mkdir -p $out/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas
     cp -rf ${pkgs.gnome3.gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas*/glib-2.0/schemas/*.xml $out/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas

     ${concatMapStrings (pkg: "cp -rf ${pkg}/share/gsettings-schemas/*/glib-2.0/schemas/*.xml $out/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas\n") cfg.extraGSettingsOverridePackages}

     chmod -R a+w $out/share/gsettings-schemas/nixos-gsettings-overrides
     cat - > $out/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas/nixos-defaults.gschema.override <<- EOF
       [org.gnome.desktop.background]
       picture-uri='${pkgs.nixos-artwork.wallpapers.gnome-dark}/share/artwork/gnome/Gnome_Dark.png'

       [org.gnome.desktop.screensaver]
       picture-uri='${pkgs.nixos-artwork.wallpapers.gnome-dark}/share/artwork/gnome/Gnome_Dark.png'

       ${cfg.extraGSettingsOverrides}
     EOF

     ${pkgs.glib.dev}/bin/glib-compile-schemas $out/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas/
    '';

in

{
  options = {

    services.xserver.desktopManager.elementary = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable the elementary desktop manager";
      };

      extraGSettingsOverrides = mkOption {
        default = "";
        type = types.lines;
        description = "Additional gsettings overrides.";
      };

      extraGSettingsOverridePackages = mkOption {
        default = [];
        type = types.listOf types.path;
        description = "List of packages for which gsettings are overridden.";
      };

      debug = mkEnableOption "gnome-session debug messages";

    };

  };


  config = mkIf cfg.enable {

    services.bamf.enable = true;
    security.polkit.enable = true;
    services.udisks2.enable = true;
    services.accounts-daemon.enable = true;
    services.geoclue2.enable = mkDefault true;
    services.dleyna-renderer.enable = mkDefault true;
    services.dleyna-server.enable = mkDefault true;
    services.gnome3.at-spi2-core.enable = true;
    services.gnome3.evolution-data-server.enable = true;
    services.gnome3.gnome-keyring.enable = true;
    services.gnome3.gvfs.enable = true;
    hardware.pulseaudio.enable = mkDefault true;
    networking.networkmanager.enable = mkDefault true;
    services.upower.enable = config.powerManagement.enable;
    services.colord.enable = mkDefault true;
    hardware.bluetooth.enable = mkDefault true;
    services.xserver.libinput.enable = mkDefault true; # for controlling touchpad settings via gnome control center
    services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];

    environment.systemPackages = pkgs.elementary.wingpanelIndicators ++ pkgs.elementary.apps ++ pkgs.elementary.switchboardPlugs ++ [
      pkgs.elementary.cerbere
      pkgs.elementary.elementary-gtk-theme
      pkgs.elementary.defaultIconTheme
      pkgs.elementary.gala
      pkgs.elementary.switchboard
      pkgs.elementary.wingpanel
      pkgs.gnome3.geary
      pkgs.plank

      pkgs.gnome3.dconf
      pkgs.gnome3.epiphany
      pkgs.gnome3.evolution-data-server
      pkgs.desktop-file-utils
      pkgs.shared-mime-info
      pkgs.glib
      pkgs.gtk3.out
      pkgs.glib-networking
      pkgs.gvfs
      pkgs.gnome3.gnome-menus
      pkgs.gnome3.gnome-settings-daemon
      pkgs.hicolor-icon-theme
      pkgs.gnome3.gnome-desktop
    ];

    fonts.fonts = [ pkgs.opensans-ttf ];

    services.xserver.desktopManager.session = singleton
      { name = "elementary";
        bgSupport = true;
        start = ''
          export GTK_DATA_PREFIX=${config.system.path}

          export GTK_PATH=${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0

          ${concatMapStrings (p: ''
            if [ -d "${p}/share/gsettings-schemas/${p.name}" ]; then
              export XDG_DATA_DIRS=$XDG_DATA_DIRS''${XDG_DATA_DIRS:+:}${p}/share/gsettings-schemas/${p.name}
            fi
          '') pkgs.elementary.wingpanelIndicators}

          export XDG_DATA_DIRS=$XDG_DATA_DIRS''${XDG_DATA_DIRS:+:}${pkgs.elementary.elementary-session-settings}/share

          export NIX_GSETTINGS_OVERRIDES_DIR=${nixos-gsettings-desktop-schemas}/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas

          ${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update

          ${pkgs.gnome3.gnome-session}/bin/gnome-session --session=pantheon ${optionalString cfg.debug "--debug"} &
          ${pkgs.elementary.elementary-terminal}/bin/io.elementary.terminal &
          waitPID=$!
        '';
      };

    services.xserver.updateDbusEnvironment = true;

    services.xserver.desktopManager.elementary.extraGSettingsOverridePackages = [ pkgs.gtk3 ];

    services.xserver.desktopManager.elementary.extraGSettingsOverrides = ''
    [org.gnome.desktop.interface]
    gtk-theme='elementary'
    icon-theme='elementary'
    font-name='Open Sans 9'

    [org.gnome.desktop.wm.preferences]
    button-layout='close:maximize'
    '';

    environment.variables.GIO_EXTRA_MODULES = [ "${lib.getLib pkgs.gnome3.dconf}/lib/gio/modules"
                                                "${pkgs.gnome3.glib-networking.out}/lib/gio/modules"
                                                "${pkgs.gnome3.gvfs}/lib/gio/modules" ];

    networking.networkmanager.basePackages =
      { inherit (pkgs) networkmanager modemmanager wpa_supplicant;
        inherit (pkgs.gnome3) networkmanager-openvpn networkmanager-vpnc
                              networkmanager-openconnect networkmanager-fortisslvpn
                              networkmanager-iodine networkmanager-l2tp; };

    environment.pathsToLink = [ "/share" ];

  };

}
