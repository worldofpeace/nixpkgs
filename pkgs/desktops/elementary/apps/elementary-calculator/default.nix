{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, libxml2, gtk3
, granite, libgee, gobjectIntrospection
, defaultIconTheme, appstream, wrapGAppsHook }:

mkElementary rec {
  pname = "calculator";
  version = "382cc2a4fe8e5c957e2a39b17cfa290fb8b2a9e9";

  name = "elementary-${pname}-2018-08-12";

  sha256 = "0crkcaiwhj0gnq3vvjx0cjypjikk38mpclsaxgl3jm393lpsdkxd";

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
