{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, ninja
, substituteAll, vala, gtk3, granite, libxml2, wingpanel, libgee
, xlibs, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-keyboard";
  version = "2.1.1";

  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0x0bdd9svw4sffx8pa0pqlh6mrj3fqp4mgrb4n7ys26k2w20ngnb";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
  };

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    libxml2
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    defaultIconTheme
    granite
    gtk3
    libgee
    wingpanel
  ];

  patches = [
    (substituteAll {
      src = ./xkb.patch;
      xlibs = "${xlibs.xkeyboardconfig}/share/X11/xkb/rules/evdev.xml";
    })
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  meta = with stdenv.lib; {
    description = "Keyboard Indicator for Wingpanel";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
