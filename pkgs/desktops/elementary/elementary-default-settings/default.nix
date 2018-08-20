{ mkElementary, substituteAll, gala, elementary-calendar, elementary-music
, elementary-photos, switchboard, elementary-videos, epiphany, geary, elementary-wallpapers }:

mkElementary rec {
  pname = "default-settings";
  version = "a2ca00130c16e805179fb5abd7b624a873dff2da";

  name = "elementary-${pname}-2018-08-02";

  sha256 = "13gcp342vz9w0pr9w268b4k6506z0wm7mrbb7q39zqrpl1x26xs7";

  patches = [
    (substituteAll {
      src = ./plank.patch;
      gala = "${gala}";
      elementary_calendar = "${elementary-calendar}";
      elementary_music = "${elementary-music}";
      elementary_photos = "${elementary-photos}";
      switchboard_settings = "${switchboard}";
      elementary_videos = "${elementary-videos}";
      epiphany = "${epiphany}";
      geary = "${geary}";
    })
    ./background.patch
    ./wingpanel-overrides.patch
  ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/etc/gtk-3.0
    cp -av settings.ini $out/etc/gtk-3.0

    cp -av debian/elementary-default-settings.gsettings-override $out

    mkdir -p $out/etc/skel/.config/plank
    cp -avr plank/dock1 $out/etc/skel/.config/plank

    cp -avr wingpanel.d/ $out/etc/
  '';

  meta = {
    description = "Default settings and configuration files for elementary";
  };
}
