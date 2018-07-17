{ mkElementary, pkgconfig, fetchpatch, substituteAll, makeWrapper, meson, ninja, vala
, desktop-file-utils, gettext, libxml2, glib, gtk3, granite, libgee, bamf
, gnome-settings-daemon, libcanberra, libcanberra-gtk3, gnome-desktop, mutter
, plank, gobjectIntrospection, gdk_pixbuf, defaultIconTheme, wingpanel, glibc
, elementary-gtk-theme, elementary-wallpapers, lightdm, numlockx, clutter-gtk, wrapGAppsHook }:

mkElementary rec {
  pname = "greeter";
  version = "4e73eefa1096df38a824162fe75fc05765f31844";

  name = "elementary-${pname}-2018-05-16";

  sha256 = "0545vi9cmarsdcy911gq5ihz5k51zigjp61sldgxds72sig5lwch";

  nativeBuildInputs = [
    desktop-file-utils
    gettext
    gobjectIntrospection
    libxml2
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    clutter-gtk
    defaultIconTheme
    elementary-gtk-theme
    gdk_pixbuf
    glib
    gnome-desktop
    gnome-settings-daemon
    granite
    gtk3
    libgee
    lightdm
    mutter
    wingpanel
  ];

  mesonBuildType = "debug";

  patches = [
    (fetchpatch {
      url = "https://copr-dist-git.fedorainfracloud.org/cgit/decathorpe/elementary-nightly/pantheon-greeter.git/plain/00-disable-gsettings.patch";
      sha256 = "18his4ckv6916k83a9a9n6mqhrp58ws8y9zjd4yaj1r6957927pf";
    })
    (substituteAll {
      src = ./gsd.patch;
      gnome-settings-daemon = "${gnome-settings-daemon}/libexec";
    })
  ];

  prePatch = ''
    # numlockx was hardcoded runtime dependency
    substituteInPlace  ./src/PantheonGreeter.vala \
      --replace "/usr/bin/numlockx" "${numlockx}/bin/numlockx"
  '';

  dontWrapGApps = true;

  postFixup = ''
    wrapProgram $out/bin/io.elementary.greeter \
      "''${gappsWrapperArgs[@]}"
    
    substituteInPlace $out/share/xgreeters/io.elementary.greeter.desktop \
      --replace  "Exec=io.elementary.greeter" "Exec=$out/bin/io.elementary.greeter"
    
    substituteInPlace $out/etc/lightdm/io.elementary.greeter.conf \
      --replace "#default-wallpaper=/usr/share/backgrounds/elementaryos-default" "default-wallpaper=\"${elementary-wallpapers}/usr/share/backgrounds/elementary/Ryan Schroeder.jpg\""
  '';

  meta = {
    description = "LightDM Greeter for Pantheon.";
  };
}
