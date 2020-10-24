{ config, pkgs, lib, ... }:

{
  config = lib.mkMerge [

    (lib.mkIf (lib.any (fs: fs == "s3fs") config.boot.initrd.supportedFilesystems) {
      boot.initrd.kernelModules = [ "fuse" ];

      boot.initrd.extraUtilsCommands = ''
        copy_bin_and_libs ${pkgs.fuse}/sbin/mount.fuse
        copy_bin_and_libs ${pkgs.s3fs}/bin/s3fs
        copy_bin_and_libs ${pkgs.s3fs}/bin/mount.s3fs
      '';

      boot.initrd.postDeviceCommands = ''
        # Hacky!!! fuse hard-codes the path to mount
        mkdir -p /nix/store/eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee-${pkgs.utillinux.name}-bin/bin
        ln -s $(which mount) /nix/store/eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee-${pkgs.utillinux.name}-bin/bin
        ln -s $(which umount) /nix/store/eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee-${pkgs.utillinux.name}-bin/bin
      '';
    })

    (lib.mkIf (lib.any (fs: fs == "s3fs") config.boot.supportedFilesystems) {
      system.fsPackages = [ pkgs.s3fs ];
    })

  ];
}
