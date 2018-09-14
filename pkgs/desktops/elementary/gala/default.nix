{ mkElementary, pkgconfig, meson, python3, ninja, vala, desktop-file-utils, gettext
, libxml2, gtk3, granite, libgee, bamf, gnome-settings-daemon, libcanberra
, libcanberra-gtk3, gnome-desktop, mutter, clutter, plank, gobjectIntrospection
, defaultIconTheme, appstream, appstream-glib, wrapGAppsHook }:

mkElementary rec {
  pname = "gala";
  version = "4d5a5669db652d048357d2e9bae1841a34d2f6d1";

  name = "${pname}-2018-09-10";

  sha256 = "02bn7zw50i0qmg6nry62pd1d7k4fh8zqr97sdkfk3j16v3fvn203";

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
    python3
    vala
    wrapGAppsHook
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
    chmod +x build-aux/meson/post_install.py
    patchShebangs build-aux/meson/post_install.py
  '';

  meta = {
    description = "A window & compositing manager based on mutter and designed by elementary for use with Pantheon.";
  };
}
