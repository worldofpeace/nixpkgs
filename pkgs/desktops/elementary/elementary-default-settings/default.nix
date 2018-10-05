{ stdenv, fetchFromGitHub, elementary, substituteAll, gala, elementary-calendar, elementary-music
, elementary-photos, switchboard, elementary-videos, epiphany, geary, elementary-wallpapers }:

stdenv.mkDerivation rec {
  pname = "default-settings";
  version = "c13dcc6dc628160f1e2e4133c20276945f2f9133";

  name = "elementary-${pname}-2018-09-26";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "06dwam27x5yb5gpjmlh918zr5v3b3bd9xnbxd1yhzbii7vcw5xic";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-${pname}";
    };
  };

  patches = [
    ./background.patch
    ./wingpanel-overrides.patch
  ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/etc/gtk-3.0
    cp -av settings.ini $out/etc/gtk-3.0

    cp -av debian/elementary-default-settings.gsettings-override $out/20-io.elementary.desktop.gschema.override

    cp -avr wingpanel.d/ $out/etc/
  '';

  meta = with stdenv.lib; {
    description = "Default settings and configuration files for elementary";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
