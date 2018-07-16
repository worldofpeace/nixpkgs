{ mkElementary, pkgconfig, cmake, vala, glib, gtk3
, granite, wingpanel, libindicator-gtk3, libgee
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "wingpanel-indicator-ayatana";
  version = "2.0.3";

  name = "${pname}-${version}";
  
  sha256 = "1y2fbz4iqb4r63v2cahxkwll7vaxlf5z84kri795l448v4wmi31f";

  nativeBuildInputs = [
    cmake
    gobjectIntrospection
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
    libindicator-gtk3
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  meta = {
    description = "Ayatana-Compatibility Indicator for Wingpanel";
  };
}
