{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, python3, ninja, vala
, desktop-file-utils, gettext, libxml2, gtk3, granite, libgee, bamf, libcanberra
, libcanberra-gtk3, gnome-desktop, mutter, clutter, plank, gobjectIntrospection
, defaultIconTheme, elementary-settings-daemon, appstream, appstream-glib, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "gala";
  version = "feffbf8a9345f31cb349d8d4cc545cf87afb83c4";

  name = "${pname}-2018-10-03";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1c89cwvbc0cmnk5il5sf3dy1cn2fkwf69pa9nd25irmina3m55i2";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
  };

  nativeBuildInputs = [
    appstream
    appstream-glib
    desktop-file-utils
    gettext
    gobjectIntrospection
    libxml2
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    bamf
    clutter
    defaultIconTheme
    gnome-desktop
    elementary-settings-daemon
    granite
    gtk3
    libcanberra
    libcanberra-gtk3
    libgee
    mutter
    plank
  ];

  patches = [ ./plugins-dir.patch ];

  postPatch = ''
    chmod +x build-aux/meson/post_install.py
    patchShebangs build-aux/meson/post_install.py
  '';

  meta =  with stdenv.lib; {
    description = "A window & compositing manager based on mutter and designed by elementary for use with Pantheon";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
