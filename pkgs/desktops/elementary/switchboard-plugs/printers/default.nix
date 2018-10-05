{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig
, vala, libgee, granite, gtk3, cups, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-printers";
  version = "f78b3e784ba4c35fab5d04d5ab4685d92d48dd55";

  name = "${pname}-2018-10-02";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "150c3yas41za1q9vi0gcwrpicq13rrs0fz2kl3kp2qcr404jc5sk";
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
    cups
    granite
    gtk3
    libgee
    switchboard
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = with stdenv.lib; {
    description = "Switchboard Printers Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };

}
