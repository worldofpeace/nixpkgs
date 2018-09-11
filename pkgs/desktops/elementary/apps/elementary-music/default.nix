{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, libxml2, gtk3, granite
, libgee, clutter-gtk, json-glib, libgda, libdbusmenu-glib
, libaccounts-glib, libgpod, libnotify, libpeas, libsoup
, zeitgeist, gst_all_1, defaultIconTheme, taglib, gsignond
, libgsignon-glib, wrapGAppsHook }:

mkElementary rec {
  pname = "music";
  version = "5b7f42f2a313bdb2d70c903d327bb9a575076f00";

  name = "elementary-${pname}-2018-09-10";

  sha256 = "0nzka4sp7z68ss8w51q5s287dsqkyd4vfz52rld4kfgbca7z1yaq";

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
