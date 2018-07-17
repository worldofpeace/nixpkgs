{ mkElementary }:

mkElementary rec {
  pname = "default-settings";
  version = "5.0";

  name = "elementary-${pname}-${version}";

  sha256 = "0gyv835qbr90001gda2pzngzzbbk5jf9grgfl25pqkm29s45rqq0";

  dontBuild = true;

  installPhase = ''
    mkdir $out
    cp -r ./* $out
    rm -rf $out/debian $out/README.md
    # Currently only need the settings.ini
    mkdir -p $out/etc/gtk-3.0
    mv $out/settings.ini $out/etc/gtk-3.0
  '';

  meta = {
    description = "Default settings and configuration files for elementary";
  };
}

