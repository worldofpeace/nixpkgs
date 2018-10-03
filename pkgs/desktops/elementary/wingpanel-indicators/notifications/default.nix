{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, ninja, vala, gtk3, granite
, wingpanel, libgee, dbus-glib, libwnck3, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-notifications";
  version = "2.1.0";

  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1dyv984is41fa32fxwjdqksz9cdki2mv20gwznfbzssf8ly13k6l";
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
