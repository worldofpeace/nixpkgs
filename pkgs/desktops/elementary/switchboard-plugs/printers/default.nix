{ mkElementary, meson, ninja, pkgconfig, vala, libgee, granite
, glib, gtk3, cups, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-printers";
  version = "0.1.3";

  name = "${pname}-${version}";

  sha256 = "1425x0pi162w6pswi62h4jg715smhhy246ikr0249ijs9k5f88m0";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
    cups
    glib
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