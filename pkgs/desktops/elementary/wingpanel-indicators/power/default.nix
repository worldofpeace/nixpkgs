{ mkElementary, pkgconfig, meson, python3, ninja, vala
, gtk3, granite, bamf, libgtop, libudev, wingpanel, libgee
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "wingpanel-indicator-power";
  version = "c5c4bee3573506136d4ca73a198557864256a0ca";

  name = "${pname}-2018-09-22";

  sha256 = "1ihhq6dc75715w0cj1sj5y2hnsbb0g732qy9pdhyf0kh14lnh126";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    bamf
    defaultIconTheme
    granite
    gtk3
    libgee
    libgtop
    libudev
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = {
    description = "Power Indicator for Wingpanel";
  };
}
