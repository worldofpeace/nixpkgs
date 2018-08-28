{ mkElementary, meson, ninja, pkgconfig, vala, libgee
, granite, gtk3, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-sharing";
  version = "0.1.2";

  name = "${pname}-${version}";

  sha256 = "104jdx4x4c0zqhzym3ccp0abw618803278am1hl51xm36yrh673c";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
    granite
    gtk3
    libgee
    switchboard
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = {
    description = "Switchboard Sharing Plug";
  };

}