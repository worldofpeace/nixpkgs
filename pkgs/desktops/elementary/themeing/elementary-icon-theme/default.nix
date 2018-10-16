{ stdenv, fetchFromGitHub, elementary, meson, python3,ninja, hicolor-icon-theme, gtk3 }:

stdenv.mkDerivation rec {
  pname = "icons";
  version = "5.0";

  name = "elementary-icon-theme-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "146s26q4bb5sag35iv42hrnbdciam2ajl7s5s5jayli5vp8bw08w";
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
