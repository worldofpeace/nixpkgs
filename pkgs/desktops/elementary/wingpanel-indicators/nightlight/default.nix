{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, ninja, vala
, gtk3, granite, wingpanel, libgee, libxml2, gobjectIntrospection
, defaultIconTheme, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-nightlight";
  version = "2.0.1";

  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "17pa048asbkhzz5945hjp96dnghdl72nqp1zq0b999nawnfrb339";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
  };

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
    libgee
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  meta = with stdenv.lib; {
    description = "Night Light Indicator for Wingpanel";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
