{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, ninja
, vala, gtk3, libgee, polkit, gobjectIntrospection, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "pantheon-agent-polkit";
  version = "a9ebabf0478840c9f1a614adf6d9c848be048fed";

  name = "${pname}-2018-10-03";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1q2b0x2bpmk8md1k07700c0w267rb5jjypiyq8smg5gl84876dpr";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
  };

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    gtk3
    libgee
    polkit
  ];

  meta = with stdenv.lib; {
    description = "Polkit Agent for the Pantheon Desktop";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
