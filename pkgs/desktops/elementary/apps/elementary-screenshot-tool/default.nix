{ mkElementary, pkgconfig, meson, ninja, vala, python3
, desktop-file-utils, gtk3, granite, libgee, libcanberra
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "screenshot-tool";
  version = "bbe21a949e90c34fdd3537e52033957a3d9a59e2";

  name = "elementary-${pname}-2018-10-01";

  sha256 = "1ll341bbsjzax7a02jmg7472bw9b7dh0pk8qadjysa11b87kcklw";

  nativeBuildInputs = [
    desktop-file-utils
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    python3
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
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = {
    description = "Screenshot tool designed for elementary OS";
  };
}
