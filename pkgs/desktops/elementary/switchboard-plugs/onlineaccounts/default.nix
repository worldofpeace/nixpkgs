{ stdenv, fetchFromGitHub, elementary, cmake, ninja, pkgconfig, vala
, libgee, granite, gtk3, libaccounts-glib, libgsignon-glib, gsignond
, json-glib, rest, webkitgtk, libsoup, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-onlineaccounts";
  version = "989c409fbe2be8f8c12a969503719e3938060cf1";

  name = "${pname}-2018-10-03";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "004nbxiflwpmwmrg5zrh34j3wsmai2mv7rjr02mvd9jpmf2zqz0y";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
  };

  nativeBuildInputs = [
    cmake
    gobjectIntrospection
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
    granite
    gsignond
    gtk3
    json-glib
    libaccounts-glib
    libgee
    libgsignon-glib
    libsoup
    rest
    switchboard
    webkitgtk
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = with stdenv.lib; {
    description = "Switchboard Online Accounts Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };

}
