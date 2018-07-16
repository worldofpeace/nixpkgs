{ mkElementary, meson, ninja, pkgconfig }:

mkElementary rec {
  pname = "sound-theme";
  version = "1.0";

  name = "elementary-${pname}-${version}";

  sha256 = "1dc583lq61c361arjl3s44d2k72c46bqvcqv1c3s69f2ndsnxjdz";

  buildInputs = [
    meson
    ninja
    pkgconfig
  ];

  meta = {
    description = "A set of system sounds for elementary";
  };
}