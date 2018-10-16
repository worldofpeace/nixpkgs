{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, python3, gettext, libxml2, gtk3, granite, libgee
, libcanberra, clutter-gtk, clutter-gst, defaultIconTheme, appstream, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "camera";
  version = "1.0.2";

  name = "elementary-${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1cs72dk25dpqdy4ya5is0ccgilba7kfw2dnh108ig2f1iys9jsmr";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-${pname}";
    };
  };

  nativeBuildInputs = [
    appstream
    desktop-file-utils
    gettext
    libxml2
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    clutter-gst
    clutter-gtk
    defaultIconTheme
    granite
    gtk3
    libcanberra
    libgee
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Camera app designed for elementary OS";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
