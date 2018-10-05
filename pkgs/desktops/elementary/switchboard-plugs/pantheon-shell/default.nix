{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig, vala
, libgee, granite, gexiv2, elementary-settings-daemon, gtk3, gnome-desktop
, plank, switchboard, appstream-glib, gettext, gobjectIntrospection, bamf }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-pantheon-shell";
  version = "61f8b72d7a7a703d8eb7ce602119228ecd04ff12";

  name = "${pname}-2018-09-18";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0jsqfa5g7bkq6rp6y3kzaspl95vprbhi2dkv8qr6v1mvnvcqi9nv";
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
