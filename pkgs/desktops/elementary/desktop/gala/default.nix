{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, gettext, libxml2, glib, gtk3
, granite, libgee, bamf, gnome-settings-daemon
, libcanberra, libcanberra-gtk3, gnome-desktop, mutter
, plank, gsettings-desktop-schemas, gobjectIntrospection, gdk_pixbuf
, defaultIconTheme, appstream, appstream-glib, wrapGAppsHook }:

mkElementary rec {
  pname = "gala";
  version = "8e142b9ef967d857c4cf311eaa986b4768432169";

  name = "${pname}-2018-06-27";

  sha256 = "1lv9q8xn1jm1irbqii0pmxz7zhmy7x98rp0sjiwssw0ila3ry4kv";

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
    defaultIconTheme
    glib
    gnome-desktop
    gnome-settings-daemon
    granite
    gsettings-desktop-schemas
    gtk3
    libcanberra
    libcanberra-gtk3
    libgee
    plank
    gdk_pixbuf
    mutter
  ];

  postPatch = ''
    chmod +x ./build-aux/meson/post_install.py
    patchShebangs ./build-aux/meson/post_install.py
  '';

  meta = {
    description = "A window & compositing manager based on mutter and designed by elementary for use with Pantheon.";
  };
}
