{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig
, vala, libgee, granite, gtk3, cups, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-printers";
  version = "dcefa0d3a04a72750cea912706701e5b28322e1d";

  name = "${pname}-2018-09-07";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "11pfrg8dz1riz4nj64kn074qhbjna1dy72jhmq64l5qg0n2p52n0";
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
    pkgconfig
    vala
  ];

  buildInputs = [
    cups
    granite
    gtk3
    libgee
    switchboard
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = with stdenv.lib; {
    description = "Switchboard Printers Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };

}
