{ stdenv, fetchFromGitHub, elementary, meson, ninja }:

stdenv.mkDerivation rec {
  pname = "stylesheet";
  version = "5.2.0";

  name = "elementary-gtk-theme-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0rfpqkbrrbaga8mdpr5s48f13w634dfyk4l44bmg8nxhvzcd88m4";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-gtk-theme";
    };
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = with stdenv.lib; {
    description = "GTK theme designed to be smooth, attractive, fast, and usable";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
