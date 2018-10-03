{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig, vala, libgee
, granite, gtk3, bluez, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-bluetooth";
  version = "d427ae172ae0ccc1973950b265fc24e302e5e754";

  name = "${pname}-2018-08-30";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1v88qhfm7l6vh6n6rpf1lwn1mdz433dp29c85yfxshjjbdmsilyv";
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
