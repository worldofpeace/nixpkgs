{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, python3
, ninja, vala, gtk3, granite, bamf, libgtop, libudev, wingpanel
, libgee, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-power";
  version = "824cc733e0bceaca95fa9085cc982e45d5762ead";

  name = "${pname}-2018-10-02";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1rkqa27bsfai4psp19sy61in6730da0s7nds7dkcf06a0hvjvjc2";
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

  meta = with stdenv.lib; {
    description = "Power Indicator for Wingpanel";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
