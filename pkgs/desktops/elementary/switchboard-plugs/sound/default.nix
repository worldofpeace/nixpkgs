{ mkElementary, meson, ninja, pkgconfig, vala, libgee, granite
, glib, gtk3, pulseaudio, libcanberra, libcanberra-gtk3, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-sound";
  version = "0.1";

  name = "${pname}-${version}";

  sha256 = "0vcc6ksp5gmlplvlxqb54nw23g0x7zn9fyarba3r44zb4rnlv9fk";

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
    libcanberra
    libcanberra-gtk3
    libgee
    pulseaudio
    switchboard
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = {
    description = "Switchboard Sound Plug";
  };

}