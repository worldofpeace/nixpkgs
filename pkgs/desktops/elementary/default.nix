{ pkgs, lib, gnome3 }:


lib.makeScope pkgs.newScope (self: with self; {
  vala = pkgs.vala_0_40;

  mkElementary = callPackage ./mkElementary.nix {};

  elementary-terminal = callPackage ./apps/elementary-terminal {
    inherit (gnome3) vte libgee;
  };

})