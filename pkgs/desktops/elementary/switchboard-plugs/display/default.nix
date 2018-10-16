{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig
, vala, libgee, granite, gtk3, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-display";
  version = "2.1.5";

  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0xvsrks6h46n57hfips4k1nmzfhn0zmkimrjbs4w7fp4v9y0ygn6";
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
    description = "Switchboard Displays Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
