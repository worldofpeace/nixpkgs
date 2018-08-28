{ mkElementary, pkgconfig, meson, ninja, vala, libxml2, desktop-file-utils
, gtk3, glib, granite, libgee, defaultIconTheme, gobjectIntrospection, wrapGAppsHook }:

mkElementary rec {
  pname = "shortcut-overlay";
  version = "1.0";

  name = "elementary-${pname}-${version}";

  sha256 = "0hh5fw25hbl3cdvjx4dxbhhfvf4fl3hiczlsjg7919ib6nylis1h";

  nativeBuildInputs = [
    desktop-file-utils
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
    gtk3
    libgee
  ];

  meta = {
    description = "A native OS-wide shortcut overlay to be launched by Gala";
  };
}
