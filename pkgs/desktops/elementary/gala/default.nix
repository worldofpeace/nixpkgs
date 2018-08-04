{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, gettext, libxml2, glib, gtk3
, granite, libgee, bamf, gnome-settings-daemon
, libcanberra, libcanberra-gtk3, gnome-desktop, mutter, clutter
, plank, gsettings-desktop-schemas, gobjectIntrospection, gdk_pixbuf
, defaultIconTheme, appstream, appstream-glib, wrapGAppsHook }:

mkElementary rec {
  pname = "gala";
  version = "6bdc718832644783097801cfb56ea2c71f2be8cf";

  name = "${pname}-2018-07-10";

  sha256 = "195443kjnc6yrk33cqgqagrq0s5mlymiqc5rxq2p2l90m5a3r329";

  nativeBuildInputs = [
    appstream
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
    bamf
    clutter
    defaultIconTheme
    gdk_pixbuf
    glib
    gnome-desktop
    gnome-settings-daemon
    granite
    gsettings-desktop-schemas
    gtk3
    libcanberra
    libcanberra-gtk3
    libgee
    mutter
    plank
  ];

  patches = [ ./plugins-dir.patch ];

  postPatch = ''
    chmod +x ./build-aux/meson/post_install.py
    patchShebangs ./build-aux/meson/post_install.py
  '';

  meta = {
    description = "A window & compositing manager based on mutter and designed by elementary for use with Pantheon.";
  };
}
