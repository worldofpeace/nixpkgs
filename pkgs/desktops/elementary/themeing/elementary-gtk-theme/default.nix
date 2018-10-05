{ stdenv, fetchFromGitHub, elementary, meson, ninja }:

stdenv.mkDerivation rec {
  pname = "stylesheet";
  version = "d8be6eb36531e347e777f412f6f0d8af05553371";

  name = "elementary-gtk-theme-2018-10-04";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "106lsayy6gcwfnv7ixxm7lgzwyi57by0sa37rzw9naa8fr7a2ki5";
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
