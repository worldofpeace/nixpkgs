{ mkElementary, meson, ninja, pkgconfig, substituteAll, vala, libgee, granite
, glib, gtk3, networkmanager, networkmanagerapplet, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-network";
  version = "0.1.2";

  name = "${pname}-${version}";

  sha256 = "0x8an341fdjlavgcxalfpnyack14r9hgvzbfjgwkl84ks8y1ycbz";

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