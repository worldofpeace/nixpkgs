{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, ninja, vala, gtk3, granite
, wingpanel, libgee, dbus-glib, libwnck3, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-notifications";
  version = "2.1.1";

  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0kbpqwamh0y42ak4j5icdrjkbcy045dwc3wpwpya9a80ca9s0i2x";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
  };

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    dbus-glib
    defaultIconTheme
    granite
    gtk3
    libgee
    libwnck3
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  meta = with stdenv.lib; {
    description = "Notifications Indicator for Wingpanel";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
