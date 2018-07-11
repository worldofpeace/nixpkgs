{ mkElementary, pkgconfig, meson, ninja, substituteAll, vala
, glib, gtk3, granite, libxml2, wingpanel, libgee, xlibs
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "wingpanel-indicator-keyboard";
  version = "2.1.0";

  name = "${pname}-${version}";
  
  sha256 = "0l5axkn8zirpdn4j7a8k5728pjmgi716hwmp4fwmb6vavbi42v6z";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    libxml2
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
    wingpanel
  ];

  patches = [
    (substituteAll {
      src = ./xkb.patch;
      xlibs = "${xlibs.xkeyboardconfig}/share/X11/xkb/rules/evdev.xml";
    })
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  meta = {
    description = "Keyboard Indicator for Wingpanel";
  };
}
