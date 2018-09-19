{ pkgs, lib, gnome3 }:


lib.makeScope pkgs.newScope (self: with self; {

  apps = [
    elementary-calculator elementary-calendar
    elementary-camera elementary-code elementary-files
    elementary-music elementary-photos elementary-screenshot-tool
    elementary-terminal elementary-videos switchboard-with-plugs
  ];

  artwork = [
    elementary-gtk-theme
    elementary-icon-theme
    elementary-sound-theme
    elementary-wallpapers
  ];

  desktop = [
    elementary-session-settings
    elementary-shortcut-overlay
    gala
    wingpanel-with-indicators
  ];

  services = [
    cerbere
    elementary-capnet-assist
    elementary-settings-daemon
    elementary-dpms-helper
    pantheon-agent-geoclue2
    pantheon-agent-polkit
  ];

  switchboardPlugs = [
    switchboard-plug-a11y switchboard-plug-about
    switchboard-plug-applications switchboard-plug-bluetooth
    switchboard-plug-datetime switchboard-plug-display
    switchboard-plug-keyboard switchboard-plug-mouse-touchpad
    switchboard-plug-network switchboard-plug-notifications
    switchboard-plug-onlineaccounts switchboard-plug-pantheon-shell
    switchboard-plug-power switchboard-plug-printers
    switchboard-plug-security-privacy switchboard-plug-sharing
    switchboard-plug-sound
  ];

  wingpanelIndicators = [
    wingpanel-applications-menu wingpanel-indicator-a11y
    wingpanel-indicator-bluetooth wingpanel-indicator-datetime
    wingpanel-indicator-keyboard wingpanel-indicator-network
    wingpanel-indicator-nightlight wingpanel-indicator-notifications
    wingpanel-indicator-power wingpanel-indicator-session
    wingpanel-indicator-sound
  ];

  libgda = pkgs.gnome3.libgda;
  libgee = pkgs.gnome3.libgee;
  libpeas = pkgs.gnome3.libpeas;
  vala = pkgs.vala_0_40;
  vte = pkgs.gnome3.vte;

  defaultIconTheme = elementary-icon-theme;

  mkElementary = callPackage ./mkElementary.nix { };

  extra-elementary-contracts = callPackage ./extra-elementary-contracts {
    inherit (gnome3) file-roller gnome-bluetooth;
  };

  elementary-dpms-helper = callPackage ./elementary-dpms-helper { };

  #### APPS

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

  #### DESKTOP

  elementary-default-settings = callPackage ./elementary-default-settings {
    inherit (gnome3) geary;
  };

  elementary-greeter = callPackage ./elementary-greeter {
    inherit (gnome3) gnome-settings-daemon gnome-desktop mutter;
  };

  elementary-session-settings = callPackage ./elementary-session-settings {
    inherit (gnome3) gnome-session gnome-settings-daemon gnome-keyring;
   };

  elementary-shortcut-overlay = callPackage ./elementary-shortcut-overlay { };

  gala = callPackage ./gala {
    inherit (gnome3) gnome-settings-daemon gnome-desktop mutter;
  };

  wingpanel = callPackage ./wingpanel {
    inherit (gnome3) mutter;
  };

  wingpanel-with-indicators = callPackage ./wingpanel/wrapper.nix {
    indicators = null;
  };

  wingpanel-applications-menu = callPackage ./wingpanel-applications-menu {
     inherit (gnome3) gnome-menus;
  };

  #### SERVICES

  cerbere = callPackage ./cerbere { };

  contractor = callPackage ./contractor { };

  elementary-capnet-assist = callPackage ./elementary-capnet-assist {
    inherit (gnome3) gcr;
  };

  # We're using ubuntu and elementary's patchset due to reasons
  # explained here -> https://github.com/elementary/greeter/issues/92#issuecomment-376215614
  # Take note of "I am holding off on "fixing" this bug for as long as possible."
  elementary-settings-daemon = callPackage ./elementary-settings-daemon { };

  pantheon-agent-geoclue2 = callPackage ./pantheon-agent-geoclue2 { };

  pantheon-agent-polkit = callPackage ./pantheon-agent-polkit { };

  #### WINGPANEL INDICATORS

  wingpanel-indicator-a11y = callPackage ./wingpanel-indicators/a11y { };

  wingpanel-indicator-bluetooth = callPackage ./wingpanel-indicators/bluetooth { };

  wingpanel-indicator-datetime = callPackage ./wingpanel-indicators/datetime { };

  wingpanel-indicator-keyboard = callPackage ./wingpanel-indicators/keyboard { };

  wingpanel-indicator-network = callPackage ./wingpanel-indicators/network {
    inherit (gnome3) networkmanagerapplet;
  };

  wingpanel-indicator-nightlight = callPackage ./wingpanel-indicators/nightlight { };

  wingpanel-indicator-notifications = callPackage ./wingpanel-indicators/notifications { };

  wingpanel-indicator-power = callPackage ./wingpanel-indicators/power { };

  wingpanel-indicator-session = callPackage ./wingpanel-indicators/session { };

  wingpanel-indicator-sound = callPackage ./wingpanel-indicators/sound { };

  #### SWITCHBOARD

  switchboard = callPackage ./switchboard { };

  switchboard-with-plugs = callPackage ./switchboard/wrapper.nix {
    plugs = null;
  };

  switchboard-plug-a11y = callPackage ./switchboard-plugs/a11y { };

  switchboard-plug-about = callPackage ./switchboard-plugs/about { };

  switchboard-plug-applications = callPackage ./switchboard-plugs/applications { };

  switchboard-plug-bluetooth = callPackage ./switchboard-plugs/bluetooth { };

  switchboard-plug-datetime = callPackage ./switchboard-plugs/datetime { };

  switchboard-plug-display = callPackage ./switchboard-plugs/display { };

  switchboard-plug-keyboard = callPackage ./switchboard-plugs/keyboard {
    inherit (gnome3) libgnomekbd;
  };

  switchboard-plug-mouse-touchpad = callPackage ./switchboard-plugs/mouse-touchpad { };

  switchboard-plug-network = callPackage ./switchboard-plugs/network {
    inherit (gnome3) networkmanagerapplet;
  };

  switchboard-plug-notifications = callPackage ./switchboard-plugs/notifications { };

  switchboard-plug-onlineaccounts = callPackage ./switchboard-plugs/onlineaccounts {
    inherit (gnome3) rest;
  };

  switchboard-plug-pantheon-shell = callPackage ./switchboard-plugs/pantheon-shell {
    inherit (gnome3)  gnome-settings-daemon gnome-desktop gexiv2;
  };

  switchboard-plug-power = callPackage ./switchboard-plugs/power { };

  switchboard-plug-printers = callPackage ./switchboard-plugs/printers { };

  switchboard-plug-security-privacy = callPackage ./switchboard-plugs/security-privacy { };

  switchboard-plug-sharing = callPackage ./switchboard-plugs/sharing { };

  switchboard-plug-sound = callPackage ./switchboard-plugs/sound { };

  ### THEMEING

  elementary-gtk-theme = callPackage ./themeing/elementary-gtk-theme { };

  elementary-icon-theme = callPackage ./themeing/elementary-icon-theme { };

  elementary-sound-theme = callPackage ./themeing/elementary-sound-theme { };

  elementary-wallpapers = callPackage ./themeing/elementary-wallpapers { };

  ### MISC

  elementary-print-shim = callPackage ./elementary-print-shim { };

})
