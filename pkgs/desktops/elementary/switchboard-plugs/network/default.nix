{ mkElementary, meson, ninja, pkgconfig, substituteAll, vala, libgee, granite
, gtk3, networkmanager, networkmanagerapplet, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-network";
  version = "eface27727b061879ddf29aab4e2d164f2ef5186";

  name = "${pname}-2018-09-28";

  sha256 = "1yjb2qax2x21n7r7qp5h9ap0xwagr24pin1giynzyjkvjawc42k9";

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
    networkmanager
    networkmanagerapplet
    switchboard
  ];

  patches = [
    (substituteAll {
      src = ./nma.patch;
      networkmanagerapplet = "${networkmanagerapplet}";
    })
  ];


  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = {
    description = "Switchboard Networking Plug";
  };

}
