{ stdenv, fetchFromGitHub, elementary, substituteAll, cmake, ninja
, pkgconfig, vala, granite, libgee, gettext, gtk3, appstream, gnome-menus
, json-glib, plank, bamf, switchboard, libunity, libsoup, wingpanel, libwnck3
, zeitgeist, gobjectIntrospection, defaultIconTheme, bc, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "applications-menu";
  version = "8bdec5ec33825ea887e8d1b6c7cc1e3519a505da";

  name = "wingpanel-${pname}-2018-09-27";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "18sv7xzkww9y5crncaqi8324fr8nw65ngw486fdbj8cqas5p9wif";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "wingpanel-${pname}";
    };
  };

  nativeBuildInputs = [
    appstream
    cmake
    ninja
    gettext
    gobjectIntrospection
    pkgconfig
    vala
    wrapGAppsHook
   ];

  buildInputs = [
    bamf
    defaultIconTheme
    gnome-menus
    granite
    gtk3
    json-glib
    libgee
    libsoup
    libunity
    libwnck3
    plank
    switchboard
    wingpanel
    zeitgeist
   ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";
  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  patches = [
    (substituteAll {
      src = ./bc.patch;
      exec = "${bc}/bin/bc";
    })
    ./xdg.patch
  ];

  meta = with stdenv.lib; {
    description = "Lightweight and stylish app launcher for Pantheon";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
