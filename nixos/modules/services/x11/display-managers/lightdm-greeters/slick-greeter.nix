{ config, lib, pkgs, ... }:

with lib;

let

  dmcfg = config.services.xserver.displayManager;
  ldmcfg = dmcfg.lightdm;
  xcfg = config.services.xserver;
  cfg = ldmcfg.greeters.slick-greeter;

  inherit (pkgs) writeText;

  theme = cfg.theme.package;
  icons = cfg.iconTheme.package;
  cursors = cfg.cursorTheme.package;

  # The default greeter provided with this expression is the GTK greeter.
  # Again, we need a few things in the environment for the greeter to run with
  # fonts/icons.
  wrappedSlickGreeter = pkgs.runCommand "slick-greeter" {
      buildInputs = [ pkgs.makeWrapper ];
      preferLocalBuild = true;
    } ''
      # This wrapper ensures that we actually get themes
      makeWrapper ${pkgs.slick-greeter}/bin/slick-greeter \
        $out/greeter \
        --prefix PATH : "${lib.getBin pkgs.stdenv.cc.libc}/bin" \
        --set GDK_PIXBUF_MODULE_FILE "${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache" \
        --set GTK_PATH "${theme}:${pkgs.gtk3.out}" \
        --set GTK_EXE_PREFIX "${theme}" \
        --set GTK_DATA_PREFIX "${theme}" \
        --set XDG_DATA_DIRS "${theme}/share:${icons}/share" \
        --set XDG_CONFIG_HOME "${theme}/share" \
        --set XCURSOR_PATH "${cursors}/share/icons"

      cat - > $out/slick-greeter.desktop << EOF
      [Desktop Entry]
      Name=LightDM Greeter
      Comment=This runs the LightDM Greeter
      Exec=$out/greeter
      Type=Application
      EOF
    '';

in
{
  options = {

    services.xserver.displayManager.lightdm.greeters.slick-greeter = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable lightdm-gtk-greeter as the lightdm greeter.
        '';
      };

      theme = {

        package = mkOption {
          type = types.package;
          default = pkgs.gnome3.gnome-themes-extra;
          defaultText = "pkgs.gnome3.gnome-themes-extra";
          description = ''
            The package path that contains the theme given in the name option.
          '';
        };

        name = mkOption {
          type = types.str;
          default = "Adwaita";
          description = ''
            Name of the theme to use for the lightdm-gtk-greeter.
          '';
        };

      };

      iconTheme = {

        package = mkOption {
          type = types.package;
          default = pkgs.gnome3.adwaita-icon-theme;
          defaultText = "pkgs.gnome3.adwaita-icon-theme";
          description = ''
            The package path that contains the icon theme given in the name option.
          '';
        };

        name = mkOption {
          type = types.str;
          default = "Adwaita";
          description = ''
            Name of the icon theme to use for the lightdm-gtk-greeter.
          '';
        };

      };

      cursorTheme = {

        package = mkOption {
          default = pkgs.gnome3.adwaita-icon-theme;
          defaultText = "pkgs.gnome3.adwaita-icon-theme";
          description = ''
            The package path that contains the cursor theme given in the name option.
          '';
        };

        name = mkOption {
          type = types.str;
          default = "Adwaita";
          description = ''
            Name of the cursor theme to use for the lightdm-gtk-greeter.
          '';
        };

        size = mkOption {
          type = types.int;
          default = 16;
          description = ''
            Size of the cursor theme to use for the lightdm-gtk-greeter.
          '';
        };
      };

    };

  };

  config = mkIf (ldmcfg.enable && cfg.enable) {

    services.xserver.displayManager.lightdm.greeter = mkDefault {
      package = wrappedSlickGreeter;
      name = "slick-greeter";
    };

    services.xserver.displayManager.lightdm.greeters.gtk.enable = false;

  };
}
