{ pkgs, lib, gnome3 }:


lib.makeScope pkgs.newScope (self: with self; {

  wingpanelIndicators = [
    wingpanel-applications-menu wingpanel-indicator-a11y wingpanel-indicator-ayatana
    wingpanel-indicator-bluetooth wingpanel-indicator-datetime
    wingpanel-indicator-keyboard wingpanel-indicator-network
    wingpanel-indicator-nightlight wingpanel-indicator-notifications
    wingpanel-indicator-power wingpanel-indicator-power
    wingpanel-indicator-session wingpanel-indicator-sound
  ];

  apps = [
    elementary-calculator elementary-calendar
    elementary-camera elementary-code elementary-files
    elementary-music elementary-photos elementary-screenshot-tool
    elementary-terminal elementary-videos
  ];

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

  elementary-wallpapers = callPackage ./desktop/elementary-wallpapers { };

  elementary-sound-theme = callPackage ./desktop/elementary-sound-theme { };

  gala = callPackage ./desktop/gala {
    inherit (gnome3) gnome-settings-daemon gnome-desktop mutter;
   };

   wingpanel = callPackage ./desktop/wingpanel {
     inherit (gnome3) mutter;
    };

  wingpanel-applications-menu = callPackage ./desktop/wingpanel-applications-menu {
     inherit (gnome3) gnome-menus;
  };

   wingpanel-indicator-a11y = callPackage ./desktop/indicators/a11y { };
   wingpanel-indicator-ayatana = callPackage ./desktop/indicators/ayatana { };
   wingpanel-indicator-bluetooth = callPackage ./desktop/indicators/bluetooth { };
   wingpanel-indicator-datetime = callPackage ./desktop/indicators/datetime { };
   wingpanel-indicator-keyboard = callPackage ./desktop/indicators/keyboard { };
   wingpanel-indicator-network = callPackage ./desktop/indicators/network {
     inherit (gnome3) networkmanagerapplet;
   };
   wingpanel-indicator-nightlight = callPackage ./desktop/indicators/nightlight { };
   wingpanel-indicator-notifications = callPackage ./desktop/indicators/notifications { };
   wingpanel-indicator-power = callPackage ./desktop/indicators/power { };
   wingpanel-indicator-session = callPackage ./desktop/indicators/session { };
   wingpanel-indicator-sound = callPackage ./desktop/indicators/sound { };

   ### SWITCHBOARD

   switchboard = callPackage ./desktop/switchboard { };

})
