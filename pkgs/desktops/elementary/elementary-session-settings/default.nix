{ stdenv, fetchFromGitHub, elementary, gnome-keyring, gnome-session, wingpanel, orca, at-spi2-core }:

stdenv.mkDerivation rec {
  pname = "session-settings";
  version = "5.0.3";

  name = "elementary-${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1vrjm7bklkfv0dyafm312v4hxzy6lb7p1ny4ijkn48kr719gc71k";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-${pname}";
    };
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share
    cp -avr applications $out/share/

    mkdir -p $out/etc/xdg/autostart
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
  '';

  meta = with stdenv.lib; {
    description = "Session settings for elementary";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl3;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
