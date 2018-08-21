{ mkElementary, pkgconfig, meson, ninja, vala
, glib, gtk3, granite, wingpanel, accountsservice
, libgee, gsettings-desktop-schemas, gobjectIntrospection
, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "wingpanel-indicator-session";
  version = "2.1.0";

  name = "${pname}-${version}";
  
  sha256 = "16yf8ahz7ways50iabxxlbqgnp635m5nirh30yg6z94b0cbgpni3";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    accountsservice
    defaultIconTheme
    glib
    granite
    gtk3
    libgee
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  meta = {
    description = "Session Indicator for Wingpanel";
  };
}
