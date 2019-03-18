{ stdenv
, fetchFromGitHub
, pantheon
, pkgconfig
, meson
, ninja
, python3
, desktop-file-utils
, gtk3
, libgee
, clutter-gst
, clutter-gtk
, gst_all_1
, ffmpeg
, hicolor-icon-theme
, wrapGAppsHook
}:

stdenv.mkDerivation rec {
  pname = "screenrecorder";
  version = "unstable-2019-03-17";

  src = fetchFromGitHub {
    owner = "Mohelm97";
    repo = pname;
    rev = "7faf4df8b2c8e512f2e89a0bbe6a6e1424127c1d";
    sha256 = "1hikhqnk7iwgwfyg0dmkxjh63pwkqjmlh90f50fgl293k608j775";
  };


  nativeBuildInputs = [
    desktop-file-utils
    meson
    ninja
    pantheon.vala
    pkgconfig
    python3
    wrapGAppsHook
  ];

  buildInputs = [
    clutter-gst
    clutter-gtk
    pantheon.granite
    gst_all_1.gstreamer
    gtk3
    hicolor-icon-theme
    libgee
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  preConfigure = ''
    gappsWrapperArgs+=(--prefix PATH : ${stdenv.lib.makeBinPath [ ffmpeg ]})
  '';

  meta = with stdenv.lib; {
    description = "A simple screen recorder app designed for elementary OS";
    homepage = https://github.com/Mohelm97/screenrecorder;
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
