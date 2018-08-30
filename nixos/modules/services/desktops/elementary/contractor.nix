# Contractor

{ config, pkgs, lib, ... }:

with lib;

{

  ###### interface

  options = {

    services.elementary.contractor = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable contractor, a desktop-wide extension service used by elementary
        '';
      };

    };

  };


  ###### implementation

  config = mkIf config.services.elementary.contractor.enable {

    environment.systemPackages = with  pkgs.elementary; [
      contractor
      extra-elementary-contracts
    ];

    services.dbus.packages = [ pkgs.elementary.contractor ];

    environment.pathsToLink = [
      "/share/contractor"
    ];

  };

}
