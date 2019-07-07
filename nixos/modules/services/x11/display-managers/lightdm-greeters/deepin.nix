{ config, lib, pkgs, ... }:

with lib;

let

  dmcfg = config.services.xserver.displayManager;
  ldmcfg = dmcfg.lightdm;
  cfg = ldmcfg.greeters.deepin;

  xgreeters = pkgs.linkFarm "deepin-greeter-xgreeters" [{
    path = "${pkgs.deepin.dde-session-ui}/share/xgreeters/lightdm-deepin-greeter.desktop";
    name = "lightdm-deepin-greeter.desktop";
  }];

in
{
  options = {

    services.xserver.displayManager.lightdm.greeters.deepin = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable lightdm-deepin-greeter as the lightdm greeter.
        '';
      };

    };

  };

  config = mkIf (ldmcfg.enable && cfg.enable) {

    services.xserver.displayManager.lightdm.greeters.gtk.enable = false;

    services.xserver.displayManager.lightdm.greeter = mkDefault {
      package = xgreeters;
      name = "lightdm-deepin-greeter";
    };

  };
}
