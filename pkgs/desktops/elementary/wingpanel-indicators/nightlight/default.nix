{ mkElementary, pkgconfig, meson, ninja, vala
, gtk3, granite, wingpanel, libgee, libxml2
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "wingpanel-indicator-nightlight";
  version = "2.0";

  name = "${pname}-${version}";

  sha256 = "0688pg68in0353z1m2898i41xlw8rpplg2qriipiyf0rb2sm7wy3";

  nativeBuildInputs = [
    gobjectIntrospection
    libxml2
    meson
    ninja
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
    description = "Night Light Indicator for Wingpanel";
  };
}
