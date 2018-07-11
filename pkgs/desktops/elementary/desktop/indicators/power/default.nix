{ mkElementary, pkgconfig, meson, ninja, vala
, glib, gtk3, granite, bamf, libgtop, libudev
, wingpanel, libgee, gsettings-desktop-schemas
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "wingpanel-indicator-power";
  version = "2.1.2";

  name = "${pname}-${version}";
  
  sha256 = "19isgzv68y7w897xakd1jhqasqgp7pyrzrpkw9v0jx8fh7632qy4";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    bamf
    defaultIconTheme
    glib
    granite
    gsettings-desktop-schemas
    gtk3
    libgee
    libgtop
    libudev
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py    
  '';

  meta = {
    description = "Power Indicator for Wingpanel";
  };
}
