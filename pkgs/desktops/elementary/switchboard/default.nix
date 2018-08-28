{ mkElementary, pkgconfig, meson, ninja, vala, gtk3
, libgee, granite, gettext, clutter-gtk, libunity, intltool
, defaultIconTheme, wrapGAppsHook, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard";
  version = "0fc05c5422c934aab5c83307396a93b6f4cdd77c";

  name = "${pname}-2018-08-14";

  sha256 = "0nvnbycd9iiy9zb89847nwbrlwb8s9ycir33n1fyb9hpqnamym2v";

  nativeBuildInputs = [
    gettext
    gobjectIntrospection
    intltool
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    clutter-gtk
    defaultIconTheme
    granite
    gtk3
    libgee
    libunity
  ];

  patches = [ ./plugs-path-env.patch ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Extensible System Settings app for Pantheon";
  };
}
