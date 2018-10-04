{ stdenv, fetchFromGitHub, elementary, pkgconfig, cmake, ninja, vala
, intltool, libcanberra, dbus-glib, gtk3, libgee, granite, libnotify
, libunity, pango, plank, bamf, sqlite, libdbusmenu-gtk3, zeitgeist
, glib-networking, defaultIconTheme, gobjectIntrospection, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "files";
  version = "b8ef9bfa37cd2264a2cab27b7094357b3c929f15";

  name = "elementary-${pname}-2018-10-01";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1ypbg68yp41kg7i5a0p1w0qyz4yrsrrki48jn523sw76kw2k96ak";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-${pname}";
    };
  };

  nativeBuildInputs = [
    cmake
    glib-networking
    gobjectIntrospection
    intltool
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    bamf
    dbus-glib
    defaultIconTheme
    granite
    gtk3
    libcanberra
    libdbusmenu-gtk3
    libgee
    libnotify
    libunity
    pango
    plank
    sqlite
    zeitgeist
  ];

  patches = [ ./hardcode-gsettings.patch ];

  postPatch = ''
    substituteInPlace filechooser-module/FileChooserDialog.vala --subst-var-by ELEMENTARY_FILES_GSETTINGS_PATH $out/share/gsettings-schemas/${name}/glib-2.0/schemas
  '';

  meta = with stdenv.lib; {
    description = "File browser designed for elementary OS";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl3;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
