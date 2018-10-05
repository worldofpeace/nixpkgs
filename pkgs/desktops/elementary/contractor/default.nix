{ stdenv, fetchFromGitHub, elementary, meson, python3, ninja, pkgconfig, vala, glib, libgee, dbus, glib-networking, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "contractor";
  version = "250e42792324cc2ca8e3a7bdd1f7071e74560716";

  name = "${pname}-2018-10-04";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "11r3x0lzrg127rrw280rm0j4dv2kffsbqmabzka3igl4cahnb3v3";
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
    libgee
    python3
    dbus
    vala
  ];

  builtInputs = [ glib glib-networking ];

  PKG_CONFIG_DBUS_1_SESSION_BUS_SERVICES_DIR = "share/dbus-1/services";

  meta = with stdenv.lib; {
    description = "A desktop-wide extension service used by elementary OS";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
