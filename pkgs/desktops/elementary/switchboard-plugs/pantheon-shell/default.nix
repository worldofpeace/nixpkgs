{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig, vala
, libgee, granite, gexiv2, elementary-settings-daemon, gtk3, gnome-desktop
, plank, switchboard, appstream-glib, gettext, gobjectIntrospection, bamf }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-pantheon-shell";
  version = "2.7.1";

  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "00s2ng3ypy4diqyvimi7hw5z5z3fpvp2mbgxvrikwfxb061z3va2";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
  };

  nativeBuildInputs = [
    appstream-glib
    gettext
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
    bamf
    gexiv2
    gnome-desktop
    elementary-settings-daemon
    granite
    gtk3
    libgee
    plank
    switchboard
  ];

  patches = [ ./backgrounds.patch ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = with stdenv.lib; {
    description = "Switchboard Desktop Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
