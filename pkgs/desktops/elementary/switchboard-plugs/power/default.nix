{ stdenv, fetchFromGitHub, elementary, substituteAll, meson, ninja, pkgconfig, vala, libgee
, elementary-dpms-helper, makeWrapper, granite, gtk3, dbus, polkit, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-power";
  version = "91f9bf48bcca9ed5cad244954ab28d308920f000";

  name = "${pname}-2018-09-28";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0wwg1m0n8srf50x448pc2gbgadyfcyin7d14zi2k28hzd8cbxy0i";
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
    dbus
    granite
    gtk3
    libgee
    polkit
    switchboard
  ];

  patches = [
    (substituteAll {
      src = ./dpms-helper-exec.patch;
      exec = "${elementary-dpms-helper}";
    })
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";
  PKG_CONFIG_DBUS_1_SYSTEM_BUS_SERVICES_DIR = "share/dbus-1/system-services";
  PKG_CONFIG_DBUS_1_SYSCONFDIR = "etc";
  PKG_CONFIG_POLKIT_GOBJECT_1_POLICYDIR = "share/polkit-1/actions";

  meta = with stdenv.lib; {
    description = "Switchboard Power Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
