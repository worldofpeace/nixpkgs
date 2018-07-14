# No one should really use this, like ever
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.xserver.desktopManager.elementary;
in {
  
  options.services.xserver.desktopManager.elementary.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable the elementary desktop manager";
  };
  
  config = mkIf cfg.enable {
    
    services.bamf.enable = true;

    services.xserver = {
      desktopManager.gnome3.enable = true;
    };

    environment.gnome3.excludePackages = with pkgs.gnome3; [
      accerciser
      cheese
      evolution
      gnome-packagekit
      gnome-software
    ];

    environment.variables = {
      XDG_DATA_DIRS = map (p: "${p}/share/gsettings-schemas/${p.name}")
      pkgs.elementary.wingpanelIndicators;
    };

    environment.systemPackages = pkgs.elementary.wingpanelIndicators ++ pkgs.elementary.apps ++ pkgs.elementary.switchboardPlugs ++ [
      pkgs.plank
      pkgs.gnome3.geary
      pkgs.elementary.gala
      pkgs.elementary.wingpanel
      pkgs.elementary.elementary-gtk-theme
      pkgs.elementary.elementary-icon-theme
      pkgs.elementary.switchboard
    ];
  };
}
