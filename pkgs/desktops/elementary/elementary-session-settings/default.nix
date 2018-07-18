{ mkElementary, gnome-session, wingpanel }:

mkElementary rec {
  pname = "session-settings";
  version = "5.0.1";

  name = "elementary-${pname}-${version}";

  sha256 = "12yxcc2a18lldi44aphjv1wnwx9sr9d24wxs75psv69sc8xaqa37";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/pantheon
    cp -avr applications $out/share/

    # xdg autostarts are omitted because no

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

