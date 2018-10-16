{ stdenv, fetchFromGitHub, elementary, substituteAll, meson, ninja, pkgconfig, vala, libgee
, elementary-dpms-helper, makeWrapper, granite, gtk3, dbus, polkit, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-power";
  version = "2.3.4";

  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0kfnnghyzvy368sh39j4jdl7cnz2yc239hp00054lc4rjs8m61nv";
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
