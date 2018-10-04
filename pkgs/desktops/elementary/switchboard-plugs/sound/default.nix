{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig
, vala, libgee, granite, gtk3, pulseaudio, libcanberra, libcanberra-gtk3
, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-sound";
  version = "0.1.1";

  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "117wfmxmz6l9fvinbv3ymlj0lh9kwcfspw17brgkin5i9vws8qqr";
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
  ];

  buildInputs = [
    granite
    gtk3
    libcanberra
    libcanberra-gtk3
    libgee
    pulseaudio
    switchboard
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = with stdenv.lib; {
    description = "Switchboard Sound Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
