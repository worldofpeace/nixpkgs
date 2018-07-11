{ mkElementary, pkgconfig, cmake, substituteAll, vala, glib, gtk3
, granite, wingpanel, evolution-data-server, libical
, libgee, libxml2, libsoup, gobjectIntrospection
, elementary-calendar, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "wingpanel-indicator-datetime";
  version = "2.1.0";

  name = "${pname}-${version}";
  
  sha256 = "174n59dyh1g3ma12xarffqiz9mskfcd63scq46ylk0rmakmfnxg4";

  nativeBuildInputs = [
    cmake
    gobjectIntrospection
    libxml2
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    defaultIconTheme
    evolution-data-server
    glib
    granite
    gtk3
    libgee
    libical
    libsoup
    wingpanel
  ];

  patches = [
    (substituteAll {
      src = ./calendar-exec.patch;
      elementary-calendar = "${elementary-calendar}/bin/io.elementary.calendar";
    })
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  meta = {
    description = "Date & Time Indicator for Wingpanel";
  };
}
