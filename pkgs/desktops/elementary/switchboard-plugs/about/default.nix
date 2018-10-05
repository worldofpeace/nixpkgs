{ stdenv, fetchFromGitHub, elementary, substituteAll, meson, ninja, pkgconfig
, vala, libgee, granite, gtk3, switchboard, pciutils, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-about";
  version = "a6a4dfe73054b17086bbbb8eddb200d853585189";

  name = "${pname}-2018-09-29";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "07z3ksnjxcrp35gdph9xbqabg9f8brggsa215l8jvfsgksksdi0c";
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
