{ mkElementary, elementary-wallpapers }:

mkElementary rec {
  pname = "default-settings";
  version = "5.0";

  name = "elementary-${pname}-${version}";

  sha256 = "0gyv835qbr90001gda2pzngzzbbk5jf9grgfl25pqkm29s45rqq0";

  patches = [ ./background.patch ];

  dontBuild = true;

  installPhase = ''
    # settings.ini
    mkdir -p $out/etc/gtk-3.0
    cp -av settings.ini $out/etc/gtk-3.0

    cp -av debian/elementary-default-settings.gsettings-override $out
  '';

  meta = {
    description = "Default settings and configuration files for elementary";
  };
}

