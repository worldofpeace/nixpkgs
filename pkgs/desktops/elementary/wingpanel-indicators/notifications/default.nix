{ mkElementary, pkgconfig, meson, ninja, vala
, gtk3, granite, wingpanel, libgee, dbus-glib
, libwnck3, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "wingpanel-indicator-notifications";
  version = "2.1.0";

  name = "${pname}-${version}";

  sha256 = "1dyv984is41fa32fxwjdqksz9cdki2mv20gwznfbzssf8ly13k6l";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    dbus-glib
    defaultIconTheme
    granite
    gtk3
    libgee
    libwnck3
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  meta = {
    description = "Notifications Indicator for Wingpanel";
  };
}
