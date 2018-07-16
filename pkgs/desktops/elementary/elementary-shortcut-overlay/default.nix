{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, gettext, libxml2, glib, gtk3
, granite, libgee, gsettings-desktop-schemas, gobjectIntrospection
, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "shortcut-overlay";
  version = "1.0";

  name = "elementary-${pname}-${version}";

  sha256 = "0hh5fw25hbl3cdvjx4dxbhhfvf4fl3hiczlsjg7919ib6nylis1h";

  nativeBuildInputs = [
    desktop-file-utils
    gettext
    gobjectIntrospection
    libxml2
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    defaultIconTheme
    glib
    granite
    gsettings-desktop-schemas
    gtk3
    libgee
  ];

  meta = {
    description = "A native OS-wide shortcut overlay to be launched by Gala";
  };
}
