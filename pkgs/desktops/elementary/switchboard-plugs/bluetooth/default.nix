{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig, vala, libgee
, granite, gtk3, bluez, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-bluetooth";
  version = "695a16a0a7b94d718fb8da36e229ea5d1fe72600";

  name = "${pname}-2018-09-29";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "03ar8wrqmyirh4dpm62pffiha6irycl8nzbh19zhzknq74rzif91";
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
    bluez
    granite
    gtk3
    libgee
    switchboard
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = with stdenv.lib; {
    description = "Switchboard Bluetooth Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };

}
