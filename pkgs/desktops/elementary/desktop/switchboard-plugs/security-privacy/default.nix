{ mkElementary, meson, ninja, pkgconfig, vala, libgee, granite
, glib, gtk3, polkit, zeitgeist, gsettings-desktop-schemas, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-security-privacy";
  version = "0.1.3";

  name = "${pname}-${version}";

  sha256 = "0zzllcgw18z0w2h82mxqihbbdrshxmq7zsp38n5gl3b818ikfkpl";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
    glib
    granite
    gsettings-desktop-schemas
    gtk3
    libgee
    polkit
    switchboard
    zeitgeist
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Switchboard Security & Privacy Plug ";
  };

}