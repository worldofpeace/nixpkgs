{ mkElementary, lib, substituteAll, meson, ninja, pkgconfig, vala, libgee, granite
, glib, gtk3, libxml2, libgnomekbd, libxklavier, xlibs, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-keyboard";
  version = "0.3.3";

  name = "${pname}-${version}";

  sha256 = "1rp6k2pp31c5nhqn7nkhp37ndsic9ihqgjn79h7r8hj5ckm67hzs";

  nativeBuildInputs = [
    gobjectIntrospection
    libxml2
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
    libgnomekbd
    libxklavier
    switchboard
  ];

  patches = [
    (substituteAll {
      src = ./xkb.patch;
      xlibs = "${xlibs.xkeyboardconfig}/share/X11/xkb/rules/evdev.xml";
    })
  ];

  LIBRARY_PATH = lib.makeLibraryPath [ libgnomekbd ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = {
    description = "Switchboard Keyboard Plug";
  };

}