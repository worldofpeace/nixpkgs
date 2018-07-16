{ mkElementary, meson, ninja, pkgconfig, vala
, libgee, granite, glib, gtk3, dbus, polkit, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-power";
  version = "0.3.3";

  name = "${pname}-${version}";

  sha256 = "1ayxm9wd1p1xjq3cgi9p0nw5nfr4zixv191qrra5sf5kv87q1swc";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
    dbus
    glib
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