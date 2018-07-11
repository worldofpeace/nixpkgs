{ mkElementary, pkgconfig, meson, ninja, vala
, glib, gtk3, granite, libnotify, wingpanel
, libgee, gsettings-desktop-schemas, gobjectIntrospection
, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "wingpanel-indicator-bluetooth";
  version = "2.1.0";

  name = "${pname}-${version}";
  
  sha256 = "0zqw18wm72s8zz44irk8p7mksfvrdxf9gbhpd8hyyjv3j9byidzf";

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
    gsettings-desktop-schemas
    gtk3
    libgee
    libnotify
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py    
  '';

  meta = {
    description = "Bluetooth Indicator for Wingpanel";
  };
}
