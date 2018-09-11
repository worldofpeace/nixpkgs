{ mkElementary, cmake, pkgconfig, vala, granite, libgee, gettext
, gtk3, appstream, gnome-menus, json-glib, plank, bamf
, switchboard, libunity, libsoup, wingpanel, libwnck3, zeitgeist
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "applications-menu";
  version = "5316955dc5894fb35a234a7144cd49c5634bd6d4";

  name = "wingpanel-${pname}-2018-08-28";

  sha256 = "1l00inp3ifz8f10piziqa3q60zzr9h0x6ahrj7l6y6jayj2q7ppk";

  nativeBuildInputs = [
    appstream
    cmake
    gettext
    gobjectIntrospection
    pkgconfig
    vala
    wrapGAppsHook
   ];

  buildInputs = [
    bamf
    defaultIconTheme
    gnome-menus
    granite
    gtk3
    json-glib
    libgee
    libsoup
    libunity
    libwnck3
    plank
    switchboard
    wingpanel
    zeitgeist
   ];


  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";
  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  patches = [ ./xdg.patch ];

  meta = {
    description = "Lightweight and stylish app launcher for Pantheon";
  };
}
