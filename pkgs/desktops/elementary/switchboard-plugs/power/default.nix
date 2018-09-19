{ mkElementary, meson, ninja, pkgconfig, vala, libgee
, granite, gtk3, dbus, polkit, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-power";
  version = "e89b64cb8891e1207102c85170c541ba706d26df";

  name = "${pname}-2018-09-15";

  sha256 = "1s498na6dxr1hmmzhbg9dywapcpw22c8j42wvydar3sk06lk30sj";

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
