{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, gettext, libxml2, glib, gtk3
, granite, libgee, gsettings-desktop-schemas, gobjectIntrospection
, defaultIconTheme, intltool, libchamplain, clutter, folks
, geocode-glib, libnotify, libical, evolution-data-server, appstream-glib, wrapGAppsHook }:

mkElementary rec {
  pname = "calendar";
  version = "a1ac3bb2ea35bec4186ab5990fa810489dc9bccf";

  name = "elementary-${pname}-2018-08-13";

  sha256 = "0y3zc6i2zxwqb2ax2ckq4876np4xynk91rfcb3wyna34il8kgawa";

  nativeBuildInputs = [
    appstream-glib
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
    clutter
    defaultIconTheme
    evolution-data-server
    folks
    geocode-glib
    glib
    granite
    gsettings-desktop-schemas
    gtk3
    libchamplain
    libgee
    libical
    libnotify
  ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Desktop calendar app designed for elementary OS";
  };
}
