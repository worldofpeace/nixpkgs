{ stdenv, fetchFromGitHub, elementary, substituteAll, gala, elementary-calendar, elementary-music
, elementary-photos, switchboard, elementary-videos, epiphany, geary, elementary-wallpapers }:

stdenv.mkDerivation rec {
  pname = "default-settings";
  version = "5.0";

  name = "elementary-${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0gyv835qbr90001gda2pzngzzbbk5jf9grgfl25pqkm29s45rqq0";
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
