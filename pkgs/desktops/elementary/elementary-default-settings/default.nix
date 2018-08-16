{ mkElementary, elementary-wallpapers }:

mkElementary rec {
  pname = "default-settings";
  version = "a2ca00130c16e805179fb5abd7b624a873dff2da";

  name = "elementary-${pname}-2018-08-02";

  sha256 = "13gcp342vz9w0pr9w268b4k6506z0wm7mrbb7q39zqrpl1x26xs7";

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

