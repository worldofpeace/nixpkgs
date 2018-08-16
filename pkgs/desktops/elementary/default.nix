{ pkgs, lib, gnome3 }:


lib.makeScope pkgs.newScope (self: with self; {
  vala = pkgs.vala_0_40;
  libgee = pkgs.gnome3.libgee;
  libgda = pkgs.gnome3.libgda;
  libpeas = pkgs.gnome3.libpeas;

  defaultIconTheme = elementary-icon-theme;

  mkElementary = callPackage ./mkElementary.nix { };

  elementary-calculator = callPackage ./apps/elementary-calculator { };

  elementary-camera = callPackage ./apps/elementary-camera { };

  elementary-gtk-theme = callPackage ./elementary-gtk-theme { };

  elementary-icon-theme = callPackage ./elementary-icon-theme { };

  elementary-music = callPackage ./apps/elementary-music { };

  elementary-screenshot-tool = callPackage ./apps/elementary-screenshot-tool { };

  elementary-terminal = callPackage ./apps/elementary-terminal { };

  elementary-videos = callPackage ./apps/elementary-videos { };
})