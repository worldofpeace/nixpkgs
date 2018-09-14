{ mkElementary, pkgconfig, meson, python3, ninja, vala
, gtk3, granite, bamf, libgtop, libudev, wingpanel, libgee
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "wingpanel-indicator-power";
  version = "4b81a0c0c3d923bae4eac0af7eb2e21e03835cf2";

  name = "${pname}-2018-09-06";

  sha256 = "1r0hm3pg6b96dkvz67f5kgbwa8s7rh13yyydfya8f68yqsygyjmj";

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
