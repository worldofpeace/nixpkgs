{ stdenv, fetchFromGitHub, elementary, meson, python3,ninja, hicolor-icon-theme, gtk3 }:

stdenv.mkDerivation rec {
  pname = "icons";
  version = "8afc3260c031ff045c6aa1d7c5599226b41c3e70";

  name = "elementary-icon-theme-2018-10-03";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0ab7a8c6s29xh4z7p71gr1r778mw5v212jjsr0l867zilgnjkcam";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-icon-theme";
    };
  };

  nativeBuildInputs = [
    meson
    ninja
    python3
  ];

  buildInputs = [ gtk3 ];

  propagatedBuildInputs = [ hicolor-icon-theme ];

  mesonFlags = [
    "-Dvolume_icons=false"
    "-Dpalettes=false"
  ];

  postPatch = ''
    chmod +x meson/symlink.py
    patchShebangs meson/symlink.py
  '';

  postFixup = "gtk-update-icon-cache $out/share/icons/elementary";

  meta = with stdenv.lib; {
    description = "Named, vector icons for elementary OS";
    longDescription = ''
      An original set of vector icons designed specifically for elementary OS and its desktop environment: Pantheon.
    '';
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
