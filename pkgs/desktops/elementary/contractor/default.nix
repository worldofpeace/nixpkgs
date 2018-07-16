 { mkElementary, meson, ninja, pkgconfig, vala, glib, libgee, dbus, glib-networking, gobjectIntrospection }:

mkElementary rec {
  pname = "contractor";
  version = "fe6f23e1d24ba1b63c76e504af8e16bb31012c97";

  name = "${pname}-2018-05-24";

  sha256 = "0cb7gh0z51fwkrv1d21sir6nv8par8f1yjmad5x3ahs10d9x7ql5";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    libgee
    dbus
    vala
  ];

  builtInputs = [ glib glib-networking ];

  PKG_CONFIG_DBUS_1_SESSION_BUS_SERVICES_DIR = "share/dbus-1/services";

  meta = {
    description = "A desktop-wide extension service used by elementary OS";
  };
}