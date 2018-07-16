{ mkElementary, meson, ninja, pkgconfig, vala, libgee, granite
, glib, gtk3, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-display";
  version = "0.1.4";

  name = "${pname}-${version}";

  sha256 = "1mbpzxdcjz03b78w8b52ji55chi3wizliysi5cw2klm5swq595k6";

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
    switchboard
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = {
    description = "Switchboard Displays Plug";
  };

}