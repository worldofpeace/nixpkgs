{ mkElementary, meson, ninja, substituteAll, pkgconfig, vala, libgee
, granite, gtk3, libxml2, switchboard, tzdata, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-datetime";
  version = "8f2eda69d99c916c0e2ae89b502a0d4657765e63";

  name = "${pname}-2018-09-10";

  sha256 = "0vgdm76bck0lmcv1f34i6g5ibg0giwry7yp82w8kmak81vw2mxlz";

  nativeBuildInputs = [
    gobjectIntrospection
    libxml2
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
      src = ./timezone.patch;
      tzdata = "${tzdata}/share/zoneinfo/zone.tab";
    })
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = {
    description = "Switchboard Date & Time Plug";
  };

}
