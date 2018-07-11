{ pkgs, lib, gnome3 }:


lib.makeScope pkgs.newScope (self: with self; {
  vala = pkgs.vala_0_40;
  libgee = pkgs.gnome3.libgee;
  libgda = pkgs.gnome3.libgda;
  libpeas = pkgs.gnome3.libpeas;
  vte = pkgs.gnome3.vte;

  defaultIconTheme = elementary-icon-theme;

  mkElementary = callPackage ./mkElementary.nix { };

  ### Apps

  elementary-calculator = callPackage ./apps/elementary-calculator { };

  elementary-calendar = callPackage ./apps/elementary-calendar {
    inherit (gnome3) folks geocode-glib;
   };

  elementary-camera = callPackage ./apps/elementary-camera { };

  elementary-code = callPackage ./apps/elementary-code {
    inherit (gnome3) libgit2-glib;
  };

  elementary-files = callPackage ./apps/elementary-files { };

  elementary-music = callPackage ./apps/elementary-music { };

  elementary-photos = callPackage ./apps/elementary-photos {
    inherit (gnome3) geocode-glib gexiv2 rest;
   };

  elementary-screenshot-tool = callPackage ./apps/elementary-screenshot-tool { };

  elementary-terminal = callPackage ./apps/elementary-terminal { };

  elementary-videos = callPackage ./apps/elementary-videos { };

  ### Desktop Components

  cerbere = callPackage ./desktop/cerbere { };

  contractor = callPackage ./desktop/contractor { };

  elementary-gtk-theme = callPackage ./desktop/elementary-gtk-theme { };

  elementary-icon-theme = callPackage ./desktop/elementary-icon-theme { };

  elementary-shortcut-overlay = callPackage ./desktop/elementary-shortcut-overlay { };

  gala = callPackage ./desktop/gala {
    inherit (gnome3) gnome-settings-daemon gnome-desktop mutter;
   };

   wingpanel = callPackage ./desktop/wingpanel {
     inherit (gnome3) mutter;
    };

   wingpanel-indicator-power = callPackage ./desktop/indicators/power { };
   wingpanel-indicator-network = callPackage ./desktop/indicators/network {
     inherit (gnome3) networkmanagerapplet;
   };
   wingpanel-indicator-bluetooth = callPackage ./desktop/indicators/bluetooth { };
   wingpanel-indicator-session = callPackage ./desktop/indicators/session { };
   wingpanel-indicator-nightlight = callPackage ./desktop/indicators/nightlight { };
   wingpanel-indicator-notifications = callPackage ./desktop/indicators/notifications { };
   wingpanel-indicator-sound = callPackage ./desktop/indicators/sound { };
   wingpanel-indicator-keyboard = callPackage ./desktop/indicators/keyboard { };
   wingpanel-indicator-ayatana = callPackage ./desktop/indicators/ayatana { };
   wingpanel-indicator-datetime = callPackage ./desktop/indicators/datetime { };
})