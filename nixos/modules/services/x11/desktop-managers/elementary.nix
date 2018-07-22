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
     cp ${pkgs.elementary.elementary-default-settings}/elementary-default-settings.gsettings-override \
     $out/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas/nixos-defaults.gschema.override

     chmod -R a+w $out/share/gsettings-schemas/nixos-gsettings-overrides

     cat <<EOF >> $out/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas/nixos-defaults.gschema.override
       [org.gnome.desktop.background]
       draw-background=true
       picture-options='zoom'
       picture-uri='${pkgs.nixos-artwork.wallpapers.gnome-dark}/share/artwork/gnome/Gnome_Dark.png'
       primary-color='#000000'

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

      sessionPath = mkOption {
        default = [];
        example = literalExample "[ pkgs.gnome3.gpaste ]";
        description = "Additional list of packages to be added to the session search path.
                       Useful for gnome shell extensions or gsettings-conditionated autostart.";
        apply = list: list;
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

          export XDG_MENU_PREFIX=gnome-

          ${concatMapStrings (p: ''
            if [ -d "${p}/share/gsettings-schemas/${p.name}" ]; then
              export XDG_DATA_DIRS=$XDG_DATA_DIRS''${XDG_DATA_DIRS:+:}${p}/share/gsettings-schemas/${p.name}
            fi

            if [ -d "${p}/lib/girepository-1.0" ]; then
              export GI_TYPELIB_PATH=$GI_TYPELIB_PATH''${GI_TYPELIB_PATH:+:}${p}/lib/girepository-1.0
              export LD_LIBRARY_PATH=$LD_LIBRARY_PATH''${LD_LIBRARY_PATH:+:}${p}/lib
            fi
          '') cfg.sessionPath}

          # So gnome-session can find the pantheon session
          export XDG_DATA_DIRS=$XDG_DATA_DIRS''${XDG_DATA_DIRS:+:}${pkgs.elementary.elementary-session-settings}/share

          # Override gsettings-desktop-schema
          export NIX_GSETTINGS_OVERRIDES_DIR=${nixos-gsettings-desktop-schemas}/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas

          export XDG_CURRENT_DESKTOP=Pantheon

          ${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update

          ${pkgs.gnome3.gnome-session}/bin/gnome-session --session=pantheon ${optionalString cfg.debug "--debug"} &
          waitPID=$!
        '';
      };

    services.xserver.desktopManager.elementary.sessionPath = pkgs.elementary.wingpanelIndicators ++ [ pkgs.gnome3.evolution-data-server ];

    services.xserver.desktopManager.elementary.extraGSettingsOverridePackages = with pkgs; [
      elementary.gala
      epiphany
      gnome3.gnome-settings-daemon
      gnome3.mutter
      gnome3.networkmanagerapplet
      gtk3
      plank
      # TODO: There's ibus stuff too
    ];

    environment.systemPackages = with pkgs;
      [
        desktop-file-utils
        glib
        glib-networking
        gtk3.out
        gvfs
        hicolor-icon-theme
        lightlocker # TODO: This probably needs work
        plank
        shared-mime-info
      ] ++ (with pkgs.elementary;
      [
        cerbere
        defaultIconTheme
        elementary-gtk-theme
        elementary-shortcut-overlay
        elementary-sound-theme
        gala
        switchboard
        wingpanel
        elementary-session-settings
      ]) ++ pkgs.elementary.wingpanelIndicators ++ pkgs.elementary.apps ++ pkgs.elementary.switchboardPlugs
      ++ (with pkgs.gnome3;
      [
        dconf
        epiphany
        geary
        gnome-bluetooth
        gnome-menus
        gnome-power-manager
      ]);

    hardware.bluetooth.enable = mkDefault true;
    hardware.pulseaudio.enable = mkDefault true;
    networking.networkmanager.enable = mkDefault true;
    security.polkit.enable = true;
    services.accounts-daemon.enable = true;
    services.bamf.enable = true;
    services.colord.enable = mkDefault true;
    services.dbus.packages =
      mkIf config.services.printing.enable [ pkgs.system-config-printer ];
    services.dleyna-renderer.enable = mkDefault true;
    services.dleyna-server.enable = mkDefault true;
    services.geoclue2.enable = mkDefault true;
    services.gnome3.at-spi2-core.enable = true;
    services.gnome3.evolution-data-server.enable = true;
    services.gnome3.gnome-keyring.enable = true;
    services.gnome3.gvfs.enable = true;
    services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];
    services.udisks2.enable = true;
    services.upower.enable = config.powerManagement.enable;
    services.xserver.libinput.enable = mkDefault true;
    services.xserver.updateDbusEnvironment = true;

    fonts.fonts = with pkgs; [ opensans-ttf roboto-mono ];
    fonts.fontconfig.defaultFonts = {
        monospace = [ "Roboto Mono" ];
        sansSerif = [ "Open Sans" ];
      };

    environment.pathsToLink = [ "/share" ];

    environment.variables.GIO_EXTRA_MODULES = [ "${lib.getLib pkgs.gnome3.dconf}/lib/gio/modules"
                                                "${pkgs.gnome3.glib-networking.out}/lib/gio/modules"
                                                "${pkgs.gnome3.gvfs}/lib/gio/modules" ];

    # Enable GTK applications to load SVG icons
    environment.variables.GDK_PIXBUF_MODULE_FILE = "${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";

    networking.networkmanager.basePackages =
      { inherit (pkgs) networkmanager modemmanager wpa_supplicant;
        inherit (pkgs.gnome3) networkmanager-openvpn networkmanager-vpnc
                              networkmanager-openconnect networkmanager-fortisslvpn
                              networkmanager-iodine networkmanager-l2tp; };

    environment.pathsToLink = [ "/share" ];

  };

}
