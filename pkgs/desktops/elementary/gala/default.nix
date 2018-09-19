{ mkElementary, pkgconfig, meson, python3, ninja, vala, desktop-file-utils, gettext
, libxml2, gtk3, granite, libgee, bamf, elementary-settings-daemon, libcanberra
, libcanberra-gtk3, gnome-desktop, mutter, clutter, plank, gobjectIntrospection
, defaultIconTheme, appstream, appstream-glib, wrapGAppsHook }:

mkElementary rec {
  pname = "gala";
  version = "1970bac81eb691838d7068fc6d59bb6ac48de2d2";

  name = "${pname}-2018-09-10";

  sha256 = "1pkzrn6k8yk9n7jx879rmkx87zcdpr0f6xn4wqrl66l1zbjrbzvr";

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
    elementary-settings-daemon
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
