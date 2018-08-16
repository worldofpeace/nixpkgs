{ mkElementary, substituteAll, gnome-settings-daemon, gnome-keyring, onboard, orca, xdg-user-dirs, gnome-session, wingpanel }:

mkElementary rec {
  pname = "session-settings";
  version = "5.0.2";

  name = "elementary-${pname}-${version}";

  sha256 = "0qvs4am8vwzxjd1pnyy7vyvl5g5pj1b7x1ay6b4w499lvj7g8i9p";

  dontBuild = true;

  patches = [
    (substituteAll {
      src = ./autostart-exec.patch;
      settings = "${gnome-settings-daemon}/libexec";
      keyring = "${gnome-keyring}/bin";
      dirs = "${xdg-user-dirs}/bin/";
    })
  ];

  installPhase = ''
    mkdir -p $out/share/pantheon
    cp -avr applications $out/share/

    mkdir -p $out/etc/xdg/autostart
    cp -av autostart/* $out/etc/xdg/autostart

    mkdir -p $out/share/gnome-session/sessions
    cp -av gnome-session/pantheon.session $out/share/gnome-session/sessions

    mkdir -p $out/share/xsessions
    cp -av xsessions/pantheon.desktop $out/share/xsessions
  '';

  postFixup = ''
    substituteInPlace $out/share/xsessions/pantheon.desktop \
      --replace "gnome-session" "${gnome-session}/bin/gnome-session" \
      --replace "wingpanel" "${wingpanel}/bin/wingpanel"
  '';

  meta = {
    description = "Session settings for elementary";
  };
}
