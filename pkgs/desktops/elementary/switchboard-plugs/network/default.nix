{ mkElementary, meson, ninja, pkgconfig, substituteAll, vala, libgee, granite
, gtk3, networkmanager, networkmanagerapplet, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-network";
  version = "5e98661ba8bb385cd87e411197d6be4829ba1ef3";

  name = "${pname}-2018-09-05";

  sha256 = "1va7cmbg3c157wmw652zk08f8583s8vm34p9yx76mldgawckf8xj";

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
