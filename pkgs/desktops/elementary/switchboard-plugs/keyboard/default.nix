{ stdenv, fetchFromGitHub, elementary, substituteAll, meson, ninja, pkgconfig, vala, libgee
, granite, gtk3, libxml2, libgnomekbd, libxklavier, xlibs, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-keyboard";
  version = "1757ad53a6bffde64a5443202fa2634019a68faa";

  name = "${pname}-2018-09-07";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0xvp44f29jg45ihwmgnyxzzz4sk6whrqmzqhkv5g91zj44bv0mc7";
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
