{ stdenv, fetchFromGitHub, elementary, substituteAll, meson, ninja, pkgconfig, vala, libgee
, granite, gtk3, libxml2, libgnomekbd, libxklavier, xlibs, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-keyboard";
  version = "e33d199ee7fa1b175b7b9af31b11ce03ee69536f";

  name = "${pname}-2018-10-04";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0sxb0322nmv50zsfmr60212azkh6qg5fjl9lpz7687r0fxyhj169";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
  };

  nativeBuildInputs = [
    gobjectIntrospection
    libxml2
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
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

  LIBRARY_PATH = stdenv.lib.makeLibraryPath [ libgnomekbd ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = with stdenv.lib; {
    description = "Switchboard Keyboard Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
