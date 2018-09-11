{ mkElementary, pkgconfig, meson, ninja, vala, desktop-file-utils
, gettext, libxml2, gtk3, granite, libgee, libcanberra, clutter-gtk
, clutter-gst, defaultIconTheme, appstream, wrapGAppsHook }:

mkElementary rec {
  pname = "camera";
  version = "19c14b73a24d8d5d7273d24c0a3676c4f5ec44d8";

  name = "elementary-${pname}-2018-09-07";

  sha256 = "130diipcxdw5dajxjjbqcjal7g8zvq2yfz90x27dl284gdw504lc";

  nativeBuildInputs = [
    appstream
    desktop-file-utils
    gettext
    libxml2
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    clutter-gst
    clutter-gtk
    defaultIconTheme
    granite
    gtk3
    libcanberra
    libgee
  ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Camera app designed for elementary OS";
  };
}
