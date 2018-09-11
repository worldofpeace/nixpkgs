{ mkElementary, meson, ninja, pkgconfig, vala, libgee
, granite, gtk3, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-display";
  version = "01507a3ef73728b4fdd25a69b259b0b3d7ec8e1e";

  name = "${pname}-2018-09-07";

  sha256 = "0j9wlbjvb58pvcfd5lkcpl70chcfcv679p63w0kz7lyvi5rbl5s2";

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
    description = "Switchboard Displays Plug";
  };

}
