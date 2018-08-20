{ pkgs, lib, gnome3 }:


lib.makeScope pkgs.newScope (self: with self; {
  vala = pkgs.vala_0_40;

  mkElementary = callPackage ./mkElementary.nix {};

  elementary-terminal = callPackage ./apps/elementary-terminal {
    inherit (gnome3) vte libgee;
  };

  elementary-calculator = callPackage ./apps/elementary-calculator {
    inherit (gnome3) libgee;
  };

  elementary-screenshot-tool = callPackage ./apps/elementary-screenshot-tool {
    inherit (gnome3) libgee;
  };

  elementary-music = callPackage ./apps/elementary-music {
    inherit (gnome3) libgee libgda libpeas;
  };

  elementary-videos = callPackage ./apps/elementary-videos {
    inherit (gnome3) libgee;
  };

  elementary-gtk-theme = callPackage ./elementary-gtk-theme { };


})