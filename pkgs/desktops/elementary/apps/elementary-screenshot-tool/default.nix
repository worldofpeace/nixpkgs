{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, gtk3, granite, libgee, libcanberra
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "screenshot-tool";
  version = "0.1.5";

  name = "elementary-${pname}-${version}";

  sha256 = "1c9ixip25147pm30szqv7zd0xn5n9pdks6gxjxfi8dr67qzpflbd";

  nativeBuildInputs = [
    desktop-file-utils
    gobjectIntrospection
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
    libcanberra
    libgee
  ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Screenshot tool designed for elementary OS";
  };
}
