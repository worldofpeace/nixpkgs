{ mkElementary, gnome-settings-daemon, gnome-keyring, gnome-session, wingpanel, orca, at-spi2-core }:

mkElementary rec {
  pname = "session-settings";
  version = "8fb8e993cd2cab3418e7144b36e7a097759f447c";

  name = "elementary-${pname}-2018-09-11";

  sha256 = "1d0kdmc9nw9nh3bn8q33lkxjsqp5lsj1il2c5hh48m3br288wrvl";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share
    cp -avr applications $out/share/

    mkdir -p $out/etc/xdg/autostart
    cp -av ${gnome-settings-daemon}/etc/xdg/autostart/* $out/etc/xdg/autostart
    cp -av ${gnome-keyring}/etc/xdg/autostart/* $out/etc/xdg/autostart
    cp -av ${orca}/etc/xdg/autostart/* $out/etc/xdg/autostart
    cp -av ${at-spi2-core}/etc/xdg/autostart/* $out/etc/xdg/autostart

    mkdir -p $out/share/gnome-session/sessions
    cp -av gnome-session/pantheon.session $out/share/gnome-session/sessions

    mkdir -p $out/share/xsessions
    cp -av xsessions/pantheon.desktop $out/share/xsessions
  '';

  postFixup = ''
    substituteInPlace $out/share/xsessions/pantheon.desktop \
      --replace "gnome-session" "${gnome-session}/bin/gnome-session" \
      --replace "wingpanel" "${wingpanel}/bin/wingpanel"

    for f in $out/etc/xdg/autostart/*; do mv "$f" "''${f%.desktop}-pantheon.desktop"; done

    for autostart in $(grep -rl "OnlyShowIn=GNOME;" $out/etc/xdg/autostart)
    do
      echo "Patching OnlyShowIn to Pantheon in: $autostart"
      sed -i "s,OnlyShowIn=GNOME;,OnlyShowIn=Pantheon;," $autostart
    done

    # Causes problems with lightdm and because I can't get GLOBIGNORE to work.
    rm $out/etc/xdg/autostart/org.gnome.SettingsDaemon.ScreensaverProxy-pantheon.desktop
  '';

  meta = {
    description = "Session settings for elementary";
  };
}
