{ stdenv, fetchFromGitHub, elementary, pkgconfig, fetchpatch, meson
, ninja, python3, vala, desktop-file-utils, gtk3, libxml2, granite
, libnotify, vte, libgee, defaultIconTheme, appstream, gobjectIntrospection, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "terminal";
  version = "f051fd58e7a7eed693e7702ddd4448d2b00054f0";

  name = "elementary-${pname}-2018-09-26";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0bw70929girvp98lvi0hzsmshgspkf4yp23gacl3bgkl44sladkr";
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
    defaultIconTheme
    granite
    gtk3
    libgee
    libnotify
    vte
  ];

  # See https://github.com/elementary/terminal/commit/914d4b0e2d0a137f12276d748ae07072b95eff80
  mesonFlags = "-Dubuntu-bionic-patched-vte=false";

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Terminal emulator designed for elementary OS";
    longDescription = ''
      A super lightweight, beautiful, and simple terminal. Comes with sane defaults, browser-class tabs, sudo paste protection,
      smart copy/paste, and little to no configuration.
    '';
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl3;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
