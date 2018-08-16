{ mkElementary, pkgconfig, meson, ninja, vala, desktop-file-utils, gettext, libxml2
, glib, gtk3, granite, libgee, libcanberra, clutter-gtk, clutter-gst, gsettings-desktop-schemas
, gobjectIntrospection, defaultIconTheme, appstream, wrapGAppsHook }:

mkElementary rec {
  pname = "camera";
  version = "1.0.1";

  name = "elementary-${pname}-${version}";

  sha256 = "1gxwz5f8d6q5p9nah21pjh4a0m1ficypzj4g4xmprwhfxdnq4yia";

  nativeBuildInputs = [
    appstream
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
    clutter-gst
    clutter-gtk
    defaultIconTheme
    glib
    granite
    gsettings-desktop-schemas
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
