{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, gtk3, granite, libgee, libcanberra
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "screenshot-tool";
  version = "775b4d69fd52e75df0d58500728591e633f72f6d";

  name = "elementary-${pname}-2018-09-09";

  sha256 = "0wriml8drzx0ink58n7fmv0wnxvk62yp1n0gdz1bn7r6x7axfxh0";

  nativeBuildInputs = [
    desktop-file-utils
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    defaultIconTheme
    granite
    gtk3
    libcanberra
    libgee
  ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Screenshot tool designed for elementary OS";
  };
}
