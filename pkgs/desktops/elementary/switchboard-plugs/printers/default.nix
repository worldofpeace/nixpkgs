{ mkElementary, meson, ninja, pkgconfig, vala, libgee
, granite, gtk3, cups, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-printers";
  version = "dcefa0d3a04a72750cea912706701e5b28322e1d";

  name = "${pname}-2018-09-07";

  sha256 = "11pfrg8dz1riz4nj64kn074qhbjna1dy72jhmq64l5qg0n2p52n0";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
    cups
    granite
    gtk3
    libgee
    switchboard
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = {
    description = "Switchboard Printers Plug";
  };

}
