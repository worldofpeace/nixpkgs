{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig }:

stdenv.mkDerivation rec {
  pname = "sound-theme";
  version = "1.0";

  name = "elementary-${pname}-${version}";

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
