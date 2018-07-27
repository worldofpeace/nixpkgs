{ mkElementary, pkgconfig, meson, ninja, vala, gtk3, libgee
, glib, granite, gettext, clutter-gtk, libunity, gsettings-desktop-schemas
, intltool, defaultIconTheme, wrapGAppsHook, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard";
  version = "cd4124ea327ee5109e26b3f7556073edacb0f94f";

  name = "${pname}-2018-07-27";

  sha256 = "0whhbsqvfzkb3m3kbci2vc6kw3yzlhzdg1yiblh0i97hfvn1h1cy";

  nativeBuildInputs = [
    gettext
    gobjectIntrospection
    intltool
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    clutter-gtk
    defaultIconTheme
    glib
    granite
    gsettings-desktop-schemas
    gtk3
    libgee
    libunity
  ];

  patches = [ ./plugs-dir.patch ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Extensible System Settings app for Pantheon";
  };
}
