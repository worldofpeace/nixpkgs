{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, libxml2, gtk3
, granite, libgee, gobjectIntrospection
, defaultIconTheme, appstream, wrapGAppsHook }:

mkElementary rec {
  pname = "calculator";
  version = "0.1.5";

  name = "elementary-${pname}-${version}";

  sha256 = "1hw7dfarinvi741ifvymfm7ys46bv9w5s5nqy6gpx64mnldcqizk";

  nativeBuildInputs = [
    appstream
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
    granite
    gtk3
    libgee
  ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Calculator app designed for elementary OS";
  };
}
