{ config, lib, pkgs, ... }:

with lib;

let

  dmcfg = config.services.xserver.displayManager;
  ldmcfg = dmcfg.lightdm;
  cfg = ldmcfg.greeters.elementary;

  xgreeters = pkgs.linkFarm "elementary-greeter-xgreeters" [{
    path = "${pkgs.elementary.elementary-greeter}/share/xgreeters/io.elementary.greeter.desktop";
    name = "io.elementary.greeter.desktop";
  }];

in
{
  options = {

    services.xserver.displayManager.lightdm.greeters.elementary = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable elementary-greeter as the lightdm greeter.
        '';
      };

    };

  };

  config = mkIf (ldmcfg.enable && cfg.enable) {

    services.xserver.displayManager.lightdm.greeters.gtk.enable = false;

    services.xserver.displayManager.lightdm.greeter = mkDefault {
      package = xgreeters;
      name = "io.elementary.greeter";
    };

    environment.etc."lightdm/io.elementary.greeter.conf".source = "${pkgs.elementary.elementary-greeter}/etc/lightdm/io.elementary.greeter.conf";
    environment.etc."wingpanel.d/ayatana.blacklist".source =  "${pkgs.elementary.elementary-default-settings}/etc/wingpanel.d/ayatana.blacklist";
    environment.etc."wingpanel.d/io.elementary.greeter.whitelist".source = "${pkgs.elementary.elementary-default-settings}/etc/wingpanel.d/io.elementary.greeter.whitelist";

  };
}
