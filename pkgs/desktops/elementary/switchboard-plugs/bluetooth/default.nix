{ mkElementary, meson, ninja, pkgconfig, vala, libgee, granite
, glib, gtk3, bluez, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-bluetooth";
  version = "0.1.1";

  name = "${pname}-${version}";

  sha256 = "1vrkcissavim41ga08cfkcmy9dcjz2zildhawllndp2xlqvxbaz4";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
    bluez
    glib
    granite
    gtk3
    libgee
    switchboard
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = {
    description = "Switchboard Bluetooth Plug";
  };

}