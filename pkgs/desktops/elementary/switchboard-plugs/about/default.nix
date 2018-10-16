{ stdenv, fetchFromGitHub, elementary, substituteAll, meson, ninja, pkgconfig
, vala, libgee, granite, gtk3, switchboard, pciutils, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-about";
  version = "2.5.1";

  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1vwjz5gj1c30sb05wi4k2rk5l9z3sk255m0ar1das58sxfr5fyqj";
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
    switchboard
  ];

  patches = [
    (substituteAll {
      src = ./lspci-path.patch;
      pciutils = "${pciutils}";
    })
    ./remove-update-button.patch
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = with stdenv.lib; {
    description = "Switchboard About Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };

}
