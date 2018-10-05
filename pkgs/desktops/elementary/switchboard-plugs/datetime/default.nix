{ stdenv, fetchFromGitHub, elementary, meson, ninja, substituteAll, pkgconfig
, vala, libgee, granite, gtk3, libxml2, switchboard, tzdata, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-datetime";
  version = "1dccc8131cd85d9660d42d19e4ad1f90f45fdc30";

  name = "${pname}-2018-10-02";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0as9hfr835px5ymfnv48r1wifkwyjhb5x04vxz9ywdrm4z5s4avf";
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
