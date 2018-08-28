{ mkElementary, meson, ninja, pkgconfig, vala, libgee, granite
, gtk3, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-a11y";
  version = "aefb7e395fcae87cc34855b3510df026e710dac7";

  name = "${pname}-2018-07-09";

  sha256 = "0wpxrv29r86br48acg1vrvri9l9jnkn1jbj4za9njj7l1lnygn6z";

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

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = {
    description = "Switchboard Universal Access Plug";
  };

}