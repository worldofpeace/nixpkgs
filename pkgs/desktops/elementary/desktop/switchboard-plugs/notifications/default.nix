{ mkElementary, meson, ninja, pkgconfig, vala, libgee, granite
, glib, gtk3, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-notifications";
  version = "0.1.4";

  name = "${pname}-${version}";

  sha256 = "1g70g6nd01p103z9z3yv5b5mywfv5bbyfsqsfnfdnfqs6kqn5wfm";

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
    description = "Switchboard Notifications Plug";
  };

}