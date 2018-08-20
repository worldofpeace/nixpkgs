{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, gettext, libxml2, glib, gtk3
, granite, libgee, gsettings-desktop-schemas, gobjectIntrospection
, defaultIconTheme, appstream, wrapGAppsHook }:

mkElementary rec {
  pname = "calculator";
  version = "0.1.4";

  name = "elementary-${pname}-${version}";
  
  sha256 = "1zk5w4zdgglqlmz8gsaz3j452s5zy1f1a10549qhywkcvn7xylcf";

  nativeBuildInputs = [
    appstream
    desktop-file-utils
    gettext
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
    glib
    granite
    gsettings-desktop-schemas
    gtk3
    libgee
  ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py    
  '';

  meta = {
    description = "Calculator app designed for elementary OS";
  };
}
