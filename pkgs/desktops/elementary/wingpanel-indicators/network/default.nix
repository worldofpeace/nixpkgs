{ mkElementary, pkgconfig, meson, ninja, vala
, glib, gtk3, granite, networkmanager, networkmanagerapplet
, wingpanel, libgee, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "wingpanel-indicator-network";
  version = "2.2.0";

  name = "${pname}-${version}";
  
  sha256 = "1yr743y3zk79jbsxvrlmqczp0agx50jbmjij0f25k7cwmjsv78jw";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    defaultIconTheme
    glib
    granite
    gtk3
    libgee
    networkmanager
    networkmanagerapplet
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  meta = {
    description = "Network Indicator for Wingpanel";
  };
}
