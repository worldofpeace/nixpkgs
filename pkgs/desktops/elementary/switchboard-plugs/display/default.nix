{ mkElementary, meson, ninja, pkgconfig, vala, libgee
, granite, gtk3, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-display";
  version = "d10358ddc1e39f2595a10f072059ed74b2f05d8c";

  name = "${pname}-2018-10-01";

  sha256 = "0xvsrks6h46n57hfips4k1nmzfhn0zmkimrjbs4w7fp4v9y0ygn6";

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
    description = "Switchboard Displays Plug";
  };

}
