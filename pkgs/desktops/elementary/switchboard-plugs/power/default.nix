{ mkElementary, meson, ninja, pkgconfig, vala, libgee
, granite, gtk3, dbus, polkit, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-power";
  version = "beb9a285f3dc576de887ab622521f4916375775a";

  name = "${pname}-2018-08-09";

  sha256 = "09a62apd53n426mv6jps61wmanwckg41r0zg8z2v9pp5rrsk4gph";

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