{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson
, ninja, vala, desktop-file-utils, libxml2, gtk3, granite
, python3, libgee, clutter-gtk, json-glib, libgda, libgpod
, libnotify, libpeas, libsoup, zeitgeist, gst_all_1, taglib
, libdbusmenu-glib, libsignon-glib, libaccounts-glib
, defaultIconTheme, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "music";
  version = "c5ef00803ded5dfac6cddb61f46a50dc9757c63e";

  name = "elementary-${pname}-2018-10-12";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1aqnnaya1vghzwrv88llabky62mlkwxwczqj7sx0ddmhd0vipn1q";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-${pname}";
    };
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
    libsignon-glib
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
