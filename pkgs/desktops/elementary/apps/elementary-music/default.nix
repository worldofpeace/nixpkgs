{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, libxml2, gtk3, granite
, libgee, clutter-gtk, json-glib, libgda, libdbusmenu-glib
, libaccounts-glib, libgpod, libnotify, libpeas, libsoup
, zeitgeist, gst_all_1, defaultIconTheme, taglib, gsignond
, libgsignon-glib, wrapGAppsHook }:

mkElementary rec {
  pname = "music";
  version = "98f7d32e529316c9540991788c0e74e055763e4f";

  name = "elementary-${pname}-2018-08-15";

  sha256 = "03zsvwqzcdfdkxv7aq42sz27ij0cj318dbhnqp1fqr3xbdp6xj1s";

  nativeBuildInputs = [
    desktop-file-utils
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = with gst_all_1; [
    clutter-gtk
    defaultIconTheme
    granite
    gsignond
    gst-plugins-bad
    gst-plugins-base
    gst-plugins-good
    gst-plugins-ugly
    gstreamer
    gtk3
    json-glib
    libaccounts-glib
    libdbusmenu-glib
    libgda
    libgee
    libgpod
    libgsignon-glib
    libnotify
    libpeas
    libsoup
    taglib
    zeitgeist
  ];

  mesonFlags = [
    "-Dplugins=lastfm,audioplayer,cdrom,ipod"
  ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Music player and library designed for elementary OS";
  };
}
