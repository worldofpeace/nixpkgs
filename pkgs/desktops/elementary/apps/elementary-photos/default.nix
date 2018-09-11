{ mkElementary, meson, ninja, pkgconfig, vala, desktop-file-utils, intltool, gtk3, glib
, libaccounts-glib, libexif, libgee, geocode-glib, gexiv2,libgphoto2, granite, gst_all_1
, libgudev, json-glib, libraw, rest, libgsignon-glib, libsoup, sqlite, scour, webkitgtk
, libwebp, appstream, libunity, wrapGAppsHook, gobjectIntrospection, defaultIconTheme }:

mkElementary rec {
  pname = "photos";
  version = "8b81593a2efe45b987f5b624564e7dda9b91e765";

  name = "elementary-${pname}-2018-09-10";

  sha256 = "0lc5i9rc4bw039cdh1qm9bddw1735pcif56hmxjg4zqqd5brgv89";

  nativeBuildInputs = [
    appstream
    desktop-file-utils
    gobjectIntrospection
    intltool
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
