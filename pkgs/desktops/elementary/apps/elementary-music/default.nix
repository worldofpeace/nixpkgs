{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson
, ninja, vala, desktop-file-utils, libxml2, gtk3, granite
, python3, libgee, clutter-gtk, json-glib, libgda, libgpod
, libnotify, libpeas, libsoup, zeitgeist, gst_all_1, taglib
, gsignond, libdbusmenu-glib, libgsignon-glib, libaccounts-glib
, defaultIconTheme, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "music";
  version = "1f1da4e54ab246859f8e88008987fa6c51d2de83";

  name = "elementary-${pname}-2018-10-01";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1kda2ygvkng7gqi01f4szv7w68z16xpizfal3r1xvdcg1gv4ira5";
  };

  nativeBuildInputs = [
    desktop-file-utils
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = with gst_all_1; [
    clutter-gtk
    defaultIconTheme
    granite
    gsignond
    gst-plugins-bad
    gst-plugins-base
    gst-plugins-good
    gst-plugins-ugly
    gstreamer
    gtk3
    json-glib
    libaccounts-glib
    libdbusmenu-glib
    libgda
    libgee
    libgpod
    libgsignon-glib
    libnotify
    libpeas
    libsoup
    taglib
    zeitgeist
  ];

  mesonFlags = [
    "-Dplugins=lastfm,audioplayer,cdrom,ipod"
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Music player and library designed for elementary OS";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
