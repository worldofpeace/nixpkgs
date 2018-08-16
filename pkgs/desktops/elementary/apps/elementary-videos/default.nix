{ mkElementary, pkgconfig, meson, ninja , vala, desktop-file-utils, gettext
, libxml2, glib, gtk3, granite, libgee, intltool, clutter-gst, clutter-gtk
, gst_all_1, gsettings-desktop-schemas, gobjectIntrospection, defaultIconTheme
, wrapGAppsHook,  gst-ffmpeg }:

mkElementary rec {
  pname = "videos";
  version = "2.6.1";

  name = "elementary-${pname}-${version}";

  sha256 = "1q4lw2n4a4diiwfpdlpvvkghmsv4yvhzz27mrv2pv9l678f325bw";

  nativeBuildInputs = [
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
    clutter-gst
    clutter-gtk
    defaultIconTheme
    glib
    granite
    gsettings-desktop-schemas
    gst-ffmpeg
    gst-libav
    gst-plugins-bad
    gst-plugins-base
    gst-plugins-good
    gst-plugins-ugly
    gstreamer
    gtk3
    libgee
  ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Video player and library app designed for elementary OS";
  };
}
