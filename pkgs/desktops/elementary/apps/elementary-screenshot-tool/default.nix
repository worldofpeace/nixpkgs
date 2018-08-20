{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, gettext, libxml2, glib, gtk3
, granite, libgee, gsettings-desktop-schemas, gobjectIntrospection
, libcanberra, gdk_pixbuf, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "screenshot-tool";
  version = "0.1.5";

  name = "elementary-${pname}-${version}";

  sha256 = "1c9ixip25147pm30szqv7zd0xn5n9pdks6gxjxfi8dr67qzpflbd";

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

  buildInputs = [
    defaultIconTheme
    glib
    granite
    gsettings-desktop-schemas
    gtk3
    libcanberra
    libgee
  ];

  propagatedBuildInputs = [ gdk_pixbuf ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Screenshot tool designed for elementary OS";
  };
}
