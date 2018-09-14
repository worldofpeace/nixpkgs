{ mkElementary, pkgconfig, cmake, ninja, vala, intltool, libcanberra, dbus-glib
, gtk3, libgee, granite, libnotify, libunity, pango, plank, bamf, sqlite
, libdbusmenu-gtk3, zeitgeist, glib-networking, defaultIconTheme, gobjectIntrospection, wrapGAppsHook }:

mkElementary rec {
  pname = "files";
  version = "27df27c1c7242f2d997b96a4e55f6b86233d7e26";

  name = "elementary-${pname}-2018-09-05";

  sha256 = "1c7ymf4za1ffcih3b4x528sn9ckp6vz05k88bv44a5kva5kad8mm";

  nativeBuildInputs = [
    cmake
    glib-networking
    gobjectIntrospection
    intltool
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    bamf
    dbus-glib
    defaultIconTheme
    granite
    gtk3
    libcanberra
    libdbusmenu-gtk3
    libgee
    libnotify
    libunity
    pango
    plank
    sqlite
    zeitgeist
  ];

  patches = [ ./hardcode-gsettings.patch ];

  postPatch = ''
    substituteInPlace filechooser-module/FileChooserDialog.vala --subst-var-by ELEMENTARY_FILES_GSETTINGS_PATH $out/share/gsettings-schemas/${name}/glib-2.0/schemas
  '';

  meta = {
    description = "File browser designed for elementary OS";
  };
}
