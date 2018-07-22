{ mkElementary, substituteAll, gnome-settings-daemon, gnome-keyring, onboard, orca, xdg-user-dirs, gnome-session, wingpanel }:

mkElementary rec {
  pname = "session-settings";
  version = "10f6581c2b6de585d5bea90d7cb8595158b3809b";

  name = "elementary-${pname}-2018-07-18";

  sha256 = "1n2x5437zlqxzs91vqacykskwdbglag0lmgsdcsbrxxiq6fpi56i";

  dontBuild = true;

  patches = [
    (substituteAll {
      src = ./autostart-exec.patch;
      settings = "${gnome-settings-daemon}/libexec";
      gnome-keyring = "${gnome-keyring}";
      onboard = "${onboard}/bin/";
      orca = "${orca}/bin/";
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
