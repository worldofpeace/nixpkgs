{ mkElementary, meson, ninja, pkgconfig, vala, desktop-file-utils, intltool, libaccounts-glib
, libexif, libgee, geocode-glib, gexiv2, glib, libgphoto2, granite, gst_all_1
, gtk3, libgudev, json-glib, libraw, rest, libgsignon-glib, libsoup, sqlite, scour
, webkitgtk, libwebp, libxml2, gettext, appstream, libunity, gsettings-desktop-schemas
, gobjectIntrospection, wrapGAppsHook, defaultIconTheme }:

mkElementary rec {
  pname = "photos";
  version = "56785e55f813eb41f7bbeeafc1ac8f4ba81146a5";

  name = "elementary-${pname}-2018-08-15";

  sha256 = "0fr76n5f0azbnv06kd0k590l24il176rz64c8907l2jy1iqyj7ki";

  nativeBuildInputs = [
    appstream
    desktop-file-utils
    gettext
    gobjectIntrospection
    intltool
    libxml2
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = with gst_all_1; [
    defaultIconTheme
    geocode-glib
    gexiv2
    granite
    gsettings-desktop-schemas
    gst-plugins-bad
    gst-plugins-base
    gst-plugins-good
    gst-plugins-ugly
    gstreamer
    gtk3
    json-glib
    libaccounts-glib
    libexif
    libgee
    libgphoto2
    libgudev
    libraw
    libsoup
    libunity
    libwebp
    rest
    scour
    sqlite
    webkitgtk
  ];

  mesonFlags = [
    "-Dplugins=false"
  ];

  # This should be provided by a post_install.py script
  postInstall = ''
    ${glib.dev}/bin/glib-compile-schemas $out/share/glib-2.0/schemas
  '';

  meta = {
    description = "Photo viewer and organizer designed for elementary OS";
  };
}
