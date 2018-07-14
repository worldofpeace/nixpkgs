{ mkElementary, meson, ninja, pkgconfig, vala, libgee, granite
, glib, gtk3, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-applications";
  version = "0.1.3.1";

  name = "${pname}-${version}";

  sha256 = "086la8yl6snhf19ibksk4qnfdkzis8ks76ncm9bsyv9daxyyq5am";

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
    description = "Switchboard Applications Plug";
  };

}