{ mkElementary, pkgconfig, fetchpatch, makeWrapper, meson, ninja, vala
, desktop-file-utils, gettext, libxml2, glib, gtk3
, granite, libgee, bamf, gnome-settings-daemon
, libcanberra, libcanberra-gtk3, gnome-desktop, mutter
, plank, gobjectIntrospection, gdk_pixbuf, defaultIconTheme
, wingpanel, glibc, elementary-gtk-theme, elementary-wallpapers, lightdm, clutter-gtk, wrapGAppsHook }:

mkElementary rec {
  pname = "greeter";
  version = "6c42198b54f6d9eaaaa6c5eb8c7cae16e01dde57";

  name = "elementary-${pname}-2018-07-08";

  sha256 = "1fxb9cmgdjqa3kbcfc2gmafiyg8c19n8w64zw0zr2vn6lb14ii57";

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

  dontWrapGApps = true;

  patches = [
    # See https://github.com/elementary/greeter/pull/145
    (fetchpatch {
      url = "https://github.com/elementary/greeter/commit/37c02b076bfedbdd95bad90624a02ee84accc2f1.patch";
      sha256 = "14s6md8gn0vaayx9h2rhap9vavqkxjxpxj522pg9b706cafbkz8a";
    })
  ];

  postFixup = ''
    wrapProgram $out/bin/io.elementary.greeter \
      "''${gappsWrapperArgs[@]}"

    wrapProgram $out/bin/io.elementary.greeter-compositor \
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
