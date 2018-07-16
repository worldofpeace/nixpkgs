{ mkElementary, meson, ninja, substituteAll, pkgconfig, vala, libgee, granite
, glib, gtk3, libxml2, switchboard, tzdata, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-datetime";
  version = "0.1.3";

  name = "${pname}-${version}";

  sha256 = "0lkmdgzz7qdm0ks7nnmibaxkxy7hph2b49gvg7m3a1y8rkb7havb";

  nativeBuildInputs = [
    gobjectIntrospection
    libxml2
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
    switchboard
  ];

  patches = [
    (substituteAll {
      src = ./timezone.patch;
      tzdata = "${tzdata}/share/zoneinfo/zone.tab";
    })
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = {
    description = "Switchboard Date & Time Plug";
  };

}