 { mkElementary, meson, python3, ninja, pkgconfig, vala, glib, libgee, dbus, glib-networking, gobjectIntrospection }:

mkElementary rec {
  pname = "contractor";
  version = "0.3.4";

  name = "${pname}-${version}";

  sha256 = "1jzqv7pglhhyrkj1pfk1l624zn1822wyl5dp6gvwn4sk3iqxwwhl";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    libgee
    python3
    dbus
    vala
  ];

  builtInputs = [ glib glib-networking ];

  PKG_CONFIG_DBUS_1_SESSION_BUS_SERVICES_DIR = "share/dbus-1/services";

  meta = {
    description = "A desktop-wide extension service used by elementary OS";
  };
}
