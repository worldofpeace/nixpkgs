{ mkElementary, pkgconfig, meson, ninja , vala
, desktop-file-utils, gettext, libxml2, glib, gtk3
, granite, libgee, gsettings-desktop-schemas, gobjectIntrospection
, clutter-gtk, libdbusmenu-glib, libaccounts-glib, json-glib, libgda
, libgpod, libnotify, libpeas, libsoup, zeitgeist, gst_all_1
, defaultIconTheme, taglib, gsignond, libgsignon-glib, wrapGAppsHook }:

mkElementary rec {
  pname = "music";
  version = "f574dd639f1b0790dbf50c3048665f0b8f132d81";

  name = "elementary-${pname}-2018-06-26";

  sha256 = "0pas52kkndavpr8ia7qj6k8wzkjhygyaqxpjcnp28n3mc36ymsm3";

  nativeBuildInputs = [
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

  buildInputs = with gst_all_1; [
    clutter-gtk
    defaultIconTheme
    glib
    granite
    gsettings-desktop-schemas
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

  # TODO: We need gsignond libgsignon-glib

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Music player and library designed for elementary OS";
  };
}
