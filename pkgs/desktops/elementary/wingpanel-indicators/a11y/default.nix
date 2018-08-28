{ mkElementary, pkgconfig, cmake, vala, gtk3
, granite, wingpanel, libgee, gobjectIntrospection
, libxml2, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "wingpanel-indicator-a11y";
  version = "802edd438abfe124a156bfa509bcfa51142edf17";

  name = "${pname}-2018-04-19";

  sha256 = "0kcydnf31pg2qx7gx194n8lgz19l43q583k2370cidbg5qmkrwxz";

  nativeBuildInputs = [
    cmake
    gobjectIntrospection
    libxml2
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    defaultIconTheme
    granite
    gtk3
    libgee
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  meta = {
    description = "Universal Access Indicator for Wingpanel";
  };
}
