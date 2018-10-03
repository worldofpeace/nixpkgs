{ stdenv, fetchFromGitHub, elementary, meson, ninja }:

stdenv.mkDerivation rec {
  pname = "stylesheet";
  version = "4000a3247b2ef264d8a7cf1df6eb4877386562c9";

  name = "elementary-gtk-theme-2018-10-01";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0c40zlrm1n4bbb77gch7q2kglfdk72lsfqp8d900c227chh6skhq";
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
