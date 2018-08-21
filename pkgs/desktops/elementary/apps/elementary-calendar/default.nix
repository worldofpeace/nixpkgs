{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, gettext, libxml2, glib, gtk3
, granite, libgee, gsettings-desktop-schemas, gobjectIntrospection
, defaultIconTheme, intltool, libchamplain, clutter, folks
, geocode-glib, libnotify, libical, evolution-data-server, appstream-glib, wrapGAppsHook }:

mkElementary rec {
  pname = "calendar";
  version = "d621fb1494698c20b142f01e9d79abeea6217d8e";

  name = "elementary-${pname}-2018-07-11";
  
  sha256 = "1w3d5biisjkp0dg1gvawbzvcv1nxwh2d9y3zzsg8cfa1d2zwcfk1";

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

  # This should be provided by a post_install.py script
  postInstall = ''
    ${glib.dev}/bin/glib-compile-schemas $out/share/glib-2.0/schemas
  '';

  meta = {
    description = "Desktop calendar app designed for elementary OS";
  };
}
