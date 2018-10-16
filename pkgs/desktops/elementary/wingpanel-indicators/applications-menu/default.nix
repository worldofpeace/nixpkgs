{ stdenv, fetchFromGitHub, elementary, substituteAll, cmake, ninja
, pkgconfig, vala, granite, libgee, gettext, gtk3, appstream, gnome-menus
, json-glib, plank, bamf, switchboard, libunity, libsoup, wingpanel, libwnck3
, zeitgeist, gobjectIntrospection, defaultIconTheme, bc, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "applications-menu";
  version = "2.4.0";

  name = "wingpanel-${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1irkjs0zm4pm5rpwg6p7jq5ml78z9mkv35j4754g7c6pps6jlg8l";
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
