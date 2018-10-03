{ stdenv, fetchFromGitHub, elementary, pkgconfig, cmake
, ninja, vala, gtk3, granite, wingpanel, libgee, libxml2
, defaultIconTheme, gobjectIntrospection, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-a11y";
  version = "802edd438abfe124a156bfa509bcfa51142edf17";

  name = "${pname}-2018-04-19";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0kcydnf31pg2qx7gx194n8lgz19l43q583k2370cidbg5qmkrwxz";
  };

  nativeBuildInputs = [
    cmake
    gobjectIntrospection
    libxml2
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    defaultIconTheme
    granite
    gtk3
    libgee
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  meta = with stdenv.lib; {
    description = "Universal Access Indicator for Wingpanel";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
