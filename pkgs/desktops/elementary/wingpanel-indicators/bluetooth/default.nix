{ mkElementary, pkgconfig, meson, python3, ninja, vala
, gtk3, granite, libnotify, wingpanel, libgee, libxml2
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "wingpanel-indicator-bluetooth";
  version = "2.1.0";

  name = "${pname}-${version}";

  sha256 = "0zqw18wm72s8zz44irk8p7mksfvrdxf9gbhpd8hyyjv3j9byidzf";

  nativeBuildInputs = [
    gobjectIntrospection
    libxml2
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    defaultIconTheme
    granite
    gtk3
    libgee
    libnotify
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = {
    description = "Bluetooth Indicator for Wingpanel";
  };
}
