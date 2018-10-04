{ stdenv, fetchFromGitHub, elementary, substituteAll, gala, elementary-calendar, elementary-music
, elementary-photos, switchboard, elementary-videos, epiphany, geary, elementary-wallpapers }:

stdenv.mkDerivation rec {
  pname = "default-settings";
  version = "a2ca00130c16e805179fb5abd7b624a873dff2da";

  name = "elementary-${pname}-2018-08-02";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "13gcp342vz9w0pr9w268b4k6506z0wm7mrbb7q39zqrpl1x26xs7";
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
