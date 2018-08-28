{ mkElementary, pkgconfig, meson, ninja, vala, desktop-file-utils, gettext
, libxml2, gtk3, granite, libgee, bamf, gnome-settings-daemon, libcanberra
, libcanberra-gtk3, gnome-desktop, mutter, clutter, plank, gobjectIntrospection
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
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
    libxml2
  ];

  buildInputs = [
    bamf
    clutter
    defaultIconTheme
    gnome-desktop
    gnome-settings-daemon
    granite
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
