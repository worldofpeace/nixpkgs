{ mkElementary, meson, ninja, pkgconfig, vala, libgee
, granite, gtk3, dbus, polkit, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-power";
  version = "da754e6181536723c2f781b6216440d41ded572d";

  name = "${pname}-2018-09-10";

  sha256 = "1sppnh0vnln975vi3v1lijkcjy0apma48asfsa1ga2fxwbbkv31s";

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

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";
  PKG_CONFIG_DBUS_1_SYSTEM_BUS_SERVICES_DIR = "etc/dbus-1/system-services";
  PKG_CONFIG_DBUS_1_SYSCONFDIR = "etc";
  PKG_CONFIG_POLKIT_GOBJECT_1_POLICYDIR = "share/polkit-1/actions";

  # depends on one of the downstream patches to gnome-settings-daemon from ubuntu
  patches = [ ./no-e-dpms-helper.patch ];

  meta = {
    description = "Switchboard Power Plug";
  };

}
