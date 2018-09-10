{ mkElementary, pkgconfig, meson, ninja, vala
, gtk3, granite, wingpanel, accountsservice, libgee
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "wingpanel-indicator-session";
  version = "69748b4342f526b7cdbe79b4168cbe35a3e7bdc6";

  name = "${pname}-2018-08-09";

  sha256 = "1qjdi3qsz6vw4wmgjbha3jzzsic83za5znjbjclkqm6cwgzznmw7";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    accountsservice
    defaultIconTheme
    granite
    gtk3
    libgee
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  meta = {
    description = "Session Indicator for Wingpanel";
  };
}
