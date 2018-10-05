{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig }:

stdenv.mkDerivation rec {
  pname = "sound-theme";
  version = "5519eaffa7cd018a00e9b1e3a7da1c6e13fbd53b";

  name = "elementary-${pname}-2018-05-21";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1dc583lq61c361arjl3s44d2k72c46bqvcqv1c3s69f2ndsnxjdz";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-${pname}";
    };
  };

  buildInputs = [
    meson
    ninja
    pkgconfig
  ];

  meta = with stdenv.lib; {
    description = "A set of system sounds for elementary";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.unlicense;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
