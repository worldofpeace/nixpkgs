{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig, substituteAll, vala
, libgee, granite, gtk3, networkmanager, networkmanagerapplet, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-network";
  version = "eface27727b061879ddf29aab4e2d164f2ef5186";

  name = "${pname}-2018-09-29";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1yjb2qax2x21n7r7qp5h9ap0xwagr24pin1giynzyjkvjawc42k9";
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
    granite
    gtk3
    libgee
    networkmanager
    networkmanagerapplet
    switchboard
  ];

  patches = [
    (substituteAll {
      src = ./nma.patch;
      networkmanagerapplet = "${networkmanagerapplet}";
    })
  ];


  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = with stdenv.lib; {
    description = "Switchboard Networking Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
