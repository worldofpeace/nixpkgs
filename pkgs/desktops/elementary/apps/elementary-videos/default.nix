{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, python3, gtk3, granite, libgee, intltool, clutter-gst
, clutter-gtk, gst_all_1, gobjectIntrospection, defaultIconTheme, wrapGAppsHook,  gst-ffmpeg }:

stdenv.mkDerivation rec {
  pname = "videos";
  version = "2.6.2";

  name = "elementary-${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1pbhkk2q83hsh2kmszsmihv84wmy6qszqzhnpasjv7vxp17k4gd2";
  };

  nativeBuildInputs = [
    desktop-file-utils
    gobjectIntrospection
    intltool
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = with gst_all_1; [
    clutter-gst
    clutter-gtk
    defaultIconTheme
    granite
    gst-ffmpeg
    gst-libav
    gst-plugins-bad
    gst-plugins-base
    gst-plugins-good
    gst-plugins-ugly
    gstreamer
    gtk3
    libgee
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Video player and library app designed for elementary OS";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
