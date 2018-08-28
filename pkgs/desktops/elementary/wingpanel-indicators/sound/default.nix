{ mkElementary, pkgconfig, meson, ninja, vala
, gtk3, granite, wingpanel, libnotify, pulseaudio
, libcanberra-gtk3, libgee, libxml2, wrapGAppsHook
, gobjectIntrospection, defaultIconTheme }:

mkElementary rec {
  pname = "wingpanel-indicator-sound";
  version = "2.1.0";

  name = "${pname}-${version}";

  sha256 = "12i0wls5zfkwc4hakqapa5jqk0574kivch83r1zccmm13bcadg5y";

  nativeBuildInputs = [
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
    libcanberra-gtk3
    libgee
    libnotify
    pulseaudio
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Sound Indicator for Wingpanel";
  };
}
