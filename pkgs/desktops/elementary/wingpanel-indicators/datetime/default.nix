{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, python3
, ninja, substituteAll, vala, gtk3, granite, wingpanel, evolution-data-server
, libical, libgee, libxml2, libsoup, gobjectIntrospection
, elementary-calendar, defaultIconTheme, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-datetime";
  version = "27afe7a5d369361b5c985726a0c636476f219d7d";

  name = "${pname}-2018-08-09";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1zf8pzww7xyv6mhpm2kdxa0s3a1najmwrdc90svdmpfvvjqqsfv5";
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
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    defaultIconTheme
    evolution-data-server
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

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Date & Time Indicator for Wingpanel";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
