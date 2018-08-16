{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, gettext, libxml2, glib, gtk3
, granite, libgee, bamf, gnome-settings-daemon
, libcanberra, libcanberra-gtk3, gnome-desktop, mutter, clutter
, plank, gsettings-desktop-schemas, gobjectIntrospection, gdk_pixbuf
, defaultIconTheme, appstream, appstream-glib, wrapGAppsHook }:

mkElementary rec {
  pname = "gala";
  version = "15f722ac8fcb601b87bc9449574ce7cc9b9c1435";

  name = "${pname}-2018-07-29";

  sha256 = "0v04l63nawv7mrdi7m85arhfnq2c4r8bg0h5vf8rn6r8lxxm9lfj";

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
