{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, gtk3, granite, libgee, intltool
, libchamplain, clutter, folks, geocode-glib
, libnotify, libical, evolution-data-server, appstream-glib
, defaultIconTheme, gobjectIntrospection, wrapGAppsHook }:

mkElementary rec {
  pname = "calendar";
  version = "a1ac3bb2ea35bec4186ab5990fa810489dc9bccf";

  name = "elementary-${pname}-2018-08-13";

  sha256 = "0y3zc6i2zxwqb2ax2ckq4876np4xynk91rfcb3wyna34il8kgawa";

  nativeBuildInputs = [
    appstream-glib
    desktop-file-utils
    gobjectIntrospection
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
    granite
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
