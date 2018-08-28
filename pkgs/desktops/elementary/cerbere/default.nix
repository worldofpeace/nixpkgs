{ mkElementary, pkgconfig, meson, ninja, glib, libgee, vala, gobjectIntrospection, wrapGAppsHook }:

mkElementary rec {
  pname = "cerbere";
  version = "0.2.4";

  name = "${pname}-${version}";

  sha256 = "0f9jr6q5z6nir5b77f96wm9rx6r6s9i0sr1yrymg3n7jyjgrvdwp";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [ glib libgee ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "A simple service to ensure uptime of essential processes";
  };

}
