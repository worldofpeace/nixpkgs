{ mkElementary, substituteAll, meson, ninja, pkgconfig, vala, libgee
, granite, gtk3, switchboard, pciutils, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-about";
  version = "0.2.5";

  name = "${pname}-${version}";

  sha256 = "0jakjr0j5jyx4qgn1nm675xibmyd23pwx2flvdbz9wjm7h37aafl";

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

  patches = [
    (substituteAll {
      src = ./lspci-path.patch;
      pciutils = "${pciutils}";
    })
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = {
    description = "Switchboard About Plug";
  };

}