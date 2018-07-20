{ mkElementary, pkgconfig, meson, ninja, glib, libgee, vala, gsettings-desktop-schemas, gobjectIntrospection, wrapGAppsHook }:

mkElementary rec {
  pname = "cerbere";
  version = "23d15fdeca66b6a05f6dea3588897ef8bd5e93a7";

  name = "${pname}-2018-07-18";

  sha256 = "0mlvc6qbr5hn32vfgqafsj638n0kc9mh4fhkkh2a1r060asiab17";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [ glib gsettings-desktop-schemas libgee ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py    
  '';

  meta = {
    description = "A simple service to ensure uptime of essential processes";
  };
}
