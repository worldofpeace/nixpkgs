{ stdenv, fetchFromGitHub, elementary, meson, ninja, substituteAll, pkgconfig
, vala, libgee, granite, gtk3, libxml2, switchboard, tzdata, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-datetime";
  version = "2.1.4";

  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0j8mjry5r66s2jvb0nv4hckc1rymh00jcqp5y8vlzglifvd3ck08";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
  };

  nativeBuildInputs = [
    gobjectIntrospection
    libxml2
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
      src = ./timezone.patch;
      tzdata = "${tzdata}/share/zoneinfo/zone.tab";
    })
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = with stdenv.lib; {
    description = "Switchboard Date & Time Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
