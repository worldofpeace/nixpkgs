{ mkElementary, pkgconfig, meson, ninja , vala, desktop-file-utils
, gtk3, granite, libgee, intltool, clutter-gst, clutter-gtk, gst_all_1
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook,  gst-ffmpeg }:

mkElementary rec {
  pname = "videos";
  version = "59dc6d61b0ad4a7e91cdda076169cd328f58a0c8";

  name = "elementary-${pname}-2018-08-25";

  sha256 = "0kgdplc7w53id4059wcsarhslyqggzpqhy4wvkpvlna6pn9pzm0l";

  nativeBuildInputs = [
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
    clutter-gst
    clutter-gtk
    defaultIconTheme
    granite
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
