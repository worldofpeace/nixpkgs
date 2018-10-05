{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, ninja, vala
, gtk3, granite, networkmanager, networkmanagerapplet, wingpanel
, libgee, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-network";
  version = "c75795071e059e7c447e7d7bfa69a9e48cda07c0";

  name = "${pname}-2018-10-03";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0k039qqlpwhl34mdhwjqhp7bz8vi432p0zfxzcdhsjhglpk8srlw";
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
    defaultIconTheme
    granite
    gtk3
    libgee
    networkmanager
    networkmanagerapplet
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  meta = with stdenv.lib; {
    description = "Network Indicator for Wingpanel";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
