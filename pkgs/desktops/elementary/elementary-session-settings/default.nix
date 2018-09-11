{ mkElementary, gnome-settings-daemon, gnome-keyring, gnome-session, wingpanel, orca }:

mkElementary rec {
  pname = "session-settings";
  version = "5.0.2";

  name = "elementary-${pname}-${version}";

  sha256 = "0qvs4am8vwzxjd1pnyy7vyvl5g5pj1b7x1ay6b4w499lvj7g8i9p";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share
    cp -avr applications $out/share/

    mkdir -p $out/etc/xdg/autostart
    cp -av ${gnome-settings-daemon}/etc/xdg/autostart/* $out/etc/xdg/autostart
    cp -av ${gnome-keyring}/etc/xdg/autostart/* $out/etc/xdg/autostart
    cp -av ${orca}/etc/xdg/autostart/* $out/etc/xdg/autostart

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
