{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, python3
, ninja, substituteAll, vala, gtk3, granite, wingpanel, evolution-data-server
, libical, libgee, libxml2, libsoup, gobjectIntrospection
, elementary-calendar, defaultIconTheme, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-datetime";
  version = "67809d961cef8d02e64e5ea7cb7b78758409596d";

  name = "${pname}-2018-10-02";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0290vqhjwlwjhdrl4rma6z02vbr8ihxrc24h3lyvgzinmvxzd427";
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
