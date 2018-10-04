{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig
, vala, libgee, granite, gtk3, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-a11y";
  version = "aefb7e395fcae87cc34855b3510df026e710dac7";

  name = "${pname}-2018-07-09";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0wpxrv29r86br48acg1vrvri9l9jnkn1jbj4za9njj7l1lnygn6z";
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

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = with stdenv.lib; {
    description = "Switchboard Universal Access Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
