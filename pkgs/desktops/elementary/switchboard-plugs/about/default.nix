{ stdenv, fetchFromGitHub, elementary, substituteAll, meson, ninja, pkgconfig
, vala, libgee, granite, gtk3, switchboard, pciutils, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-about";
  version = "08d07ed9026f9ed93860bb568ec5bcb295907ea2";

  name = "${pname}-2018-08-30";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1nfmlbkb33pdszawlappdprgib4a1nwlh77ji3j99v4fvjyn0m9z";
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
