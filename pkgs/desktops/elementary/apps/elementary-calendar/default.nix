{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, gtk3, granite, libgee, intltool
, libchamplain, clutter, folks, geocode-glib, python3
, libnotify, libical, evolution-data-server, appstream-glib
, defaultIconTheme, gobjectIntrospection, wrapGAppsHook }:

mkElementary rec {
  pname = "calendar";
  version = "8a81a8d15cd7eacebb0502ff5af928603b8f3787";

  name = "elementary-${pname}-2018-09-05";

  sha256 = "0azm7f3xs2gngw5m422a5vp5y494bhsld243anzvw1bx5r7bmj1q";

  nativeBuildInputs = [
    appstream-glib
    desktop-file-utils
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    clutter
    defaultIconTheme
    evolution-data-server
    folks
    geocode-glib
    granite
    gtk3
    libchamplain
    libgee
    libical
    libnotify
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = {
    description = "Desktop calendar app designed for elementary OS";
  };
}
