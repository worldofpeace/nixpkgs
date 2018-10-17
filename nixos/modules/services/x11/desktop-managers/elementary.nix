{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.xserver.desktopManager.elementary;

  # Remove packages of ys from xs, based on their names
  removePackagesByName = xs: ys:
    let
      pkgName = drv: (builtins.parseDrvName drv.name).name;
      ysNames = map pkgName ys;
    in
      filter (x: !(builtins.elem (pkgName x) ysNames)) xs;

  nixos-gsettings-desktop-schemas = pkgs.runCommand "nixos-gsettings-desktop-schemas" {}
    ''
     mkdir -p $out/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas
     cp -rf ${pkgs.gnome3.gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas*/glib-2.0/schemas/*.xml $out/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas

     ${concatMapStrings (pkg: "cp -rf ${pkg}/share/gsettings-schemas/*/glib-2.0/schemas/*.xml $out/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas\n") cfg.extraGSettingsOverridePackages}

     chmod -R a+w $out/share/gsettings-schemas/nixos-gsettings-overrides
     cp ${pkgs.elementary.elementary-default-settings}/20-io.elementary.desktop.gschema.override \
     $out/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas

     cat - > $out/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas/nixos-defaults.gschema.override <<- EOF
     [org.gnome.desktop.background]
     draw-background=true
     picture-options='zoom'
     picture-uri='${pkgs.nixos-artwork.wallpapers.simple-dark-gray}/share/artwork/gnome/nix-wallpaper-simple-dark-gray.png'
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
        description = ''
          Additional list of packages to be added to the session search path.
          Useful for GSettings-conditional autostart.

          Note that this should be a last resort; patching the package is preferred (see GPaste).
        '';
        apply = list: list ++ pkgs.elementary.wingpanelIndicators ++
        [
          pkgs.elementary.elementary-dpms-helper
          pkgs.elementary.elementary-settings-daemon # TODO: I shouldn't need to do this
          pkgs.elementary.pantheon-agent-geoclue2
          pkgs.gnome3.evolution-data-server
        ];
      };

      extraGSettingsOverrides = mkOption {
        default = "";
        type = types.lines;
        description = "Additional gsettings overrides.";
      };

      extraGSettingsOverridePackages = mkOption {
        default = with pkgs; [
          elementary.gala
          epiphany
          elementary.elementary-settings-daemon
          gnome3.mutter
          gtk3
          plank
        ];
        type = types.listOf types.path;
        description = "List of packages for which gsettings are overridden.";
      };

      debug = mkEnableOption "gnome-session debug messages";

    };

    environment.elementary.excludePackages = mkOption {
      default = [];
      example = literalExample "[ pkgs.elementary.elementary-camera ]";
      type = types.listOf types.package;
      description = "Which packages elementary should exclude from the default environment";
    };

  };


  config = mkIf cfg.enable {

    services.xserver.displayManager.extraSessionFilePackages = [ pkgs.elementary.elementary-session-settings ];

    services.xserver.displayManager.sessionCommands = ''
      if test "$XDG_CURRENT_DESKTOP" = "Pantheon"; then
          ${concatMapStrings (p: ''
            if [ -d "${p}/share/gsettings-schemas/${p.name}" ]; then
              export XDG_DATA_DIRS=$XDG_DATA_DIRS''${XDG_DATA_DIRS:+:}${p}/share/gsettings-schemas/${p.name}
            fi

            if [ -d "${p}/lib/girepository-1.0" ]; then
              export GI_TYPELIB_PATH=$GI_TYPELIB_PATH''${GI_TYPELIB_PATH:+:}${p}/lib/girepository-1.0
              export LD_LIBRARY_PATH=$LD_LIBRARY_PATH''${LD_LIBRARY_PATH:+:}${p}/lib
            fi
          '') cfg.sessionPath}

          # Horrible aweful workaround for https://github.com/NixOS/nixpkgs/issues/45043
          export XDG_DATA_DIRS=$XDG_DATA_DIRS''${XDG_DATA_DIRS:+:}${pkgs.networkmanagerapplet}/share

          # Makes qt applications look less alien
          export QT_QPA_PLATFORMTHEME=gtk3
          export QT_STYLE_OVERRIDE=adwaita
      fi
    '';

    # Override GSettings schemas
    environment.variables.NIX_GSETTINGS_OVERRIDES_DIR = "${nixos-gsettings-desktop-schemas}/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas";

    environment.variables.XDG_DATA_DIRS = [ "${pkgs.elementary.elementary-session-settings}/share" ];

    environment.variables.GNOME_SESSION_DEBUG = optionalString cfg.debug "1";

    environment.systemPackages = pkgs.elementary.artwork ++ pkgs.elementary.desktop ++ pkgs.elementary.services
      ++ (removePackagesByName pkgs.elementary.apps config.environment.elementary.excludePackages)
      ++ (with pkgs.gnome3;
      [
        adwaita-icon-theme
        dconf
        epiphany
        evince
        file-roller
        geary
        gnome-bluetooth
        gnome-font-viewer
        gnome-menus
        gnome-power-manager
      ])
      ++ (with pkgs;
      [
        adwaita-qt
        desktop-file-utils
        glib
        glib-networking
        gtk3.out
        gvfs
        hicolor-icon-theme
        lightlocker
        plank
        qgnomeplatform
        shared-mime-info
        xdg-user-dirs
        xfce4-13.tumbler
      ]);

    hardware.bluetooth.enable = mkDefault true;
    hardware.pulseaudio.enable = mkDefault true;
    networking.networkmanager.enable = mkDefault true;
    security.polkit.enable = true;
    services.accounts-daemon.enable = true;
    services.bamf.enable = true;
    services.zeitgeist.enable = true;
    services.elementary.contractor.enable = true;
    services.colord.enable = mkDefault true;
    services.dbus.packages = mkMerge [
      ([ pkgs.xfce4-13.tumbler pkgs.elementary.switchboard-plug-power ])
      (mkIf config.services.printing.enable  ([pkgs.system-config-printer]) )
    ];
    # elementary has pantheon-agent-geoclue2
    services.geoclue2.enableDemoAgent = false;
    services.geoclue2.enable = mkDefault true;
    services.gnome3.at-spi2-core.enable = true;
    services.gnome3.evolution-data-server.enable = true;
    # TODO: The xdg autostarts will still be in the environment (from elementary-session-settings)
    # if someone disabled this forcefully
    services.gnome3.gnome-keyring.enable = true;
    services.gnome3.gvfs.enable = true;
    services.gnome3.rygel.enable = true;
    services.udev.packages = [ pkgs.elementary.elementary-settings-daemon ];
    services.udisks2.enable = true;
    services.upower.enable = config.powerManagement.enable;
    services.xserver.libinput.enable = mkDefault true;
    services.xserver.updateDbusEnvironment = true;
    services.gsignond = {
      enable = true;
      withPlugins = with pkgs.gsignondPlugins; [ lastfm mail oauth ];
    };

    fonts.fonts = with pkgs; [ opensans-ttf roboto-mono ];
    fonts.fontconfig.defaultFonts = {
        monospace = [ "Roboto Mono" ];
        sansSerif = [ "Open Sans" ];
      };

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

    environment.pathsToLink = [
      # FIXME: modules should link subdirs of `/share` rather than relying on this
      "/share"
    ];

  };

}
