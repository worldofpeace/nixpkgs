{ mkElementary, pkgconfig, fetchpatch, substituteAll, makeWrapper, meson
, ninja, vala, desktop-file-utils, gtk3, granite, libgee, gnome-settings-daemon
, gnome-desktop, mutter, gobjectIntrospection, defaultIconTheme, wingpanel-with-indicators
, elementary-gtk-theme, elementary-wallpapers, elementary-default-settings
, lightdm, numlockx, clutter-gtk, libglvnd, dbus, wrapGAppsHook }:

mkElementary rec {
  pname = "greeter";
  version = "19c0730fded4e9ddec5a491f0e78f83c7c04eb59";

  name = "elementary-${pname}-2018-09-10";

  sha256 = "1r25ddnwa3fvqszw9v97n4h1hlaqmzcrsmacchskbrfybqnwwwxr";

  nativeBuildInputs = [
    desktop-file-utils
    gobjectIntrospection
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
    gnome-desktop
    gnome-settings-daemon
    granite
    gtk3
    libgee
    libglvnd
    lightdm
    mutter
    wingpanel-with-indicators
  ];

  patches = [
    (fetchpatch {
      url = "https://copr-dist-git.fedorainfracloud.org/cgit/decathorpe/elementary-nightly/pantheon-greeter.git/plain/00-disable-gsettings.patch";
      sha256 = "18his4ckv6916k83a9a9n6mqhrp58ws8y9zjd4yaj1r6957927pf";
    })
    (substituteAll {
      src = ./gsd.patch;
      gnome-settings-daemon = "${gnome-settings-daemon}/libexec";
    })
    ./01-sbin-bin.patch
    ./01-sysconfdir-install.patch
    ./hardcode-compositor-exec.patch
    ./hardcode-wingpanel-exec.patch
  ];

  # This constant is baked into the program
  # for discovery of the greeter configuration
  mesonFlags = [" --sysconfdir=/etc" ];

  prePatch = ''
    # numlockx was hardcoded runtime dependency
    substituteInPlace  ./src/PantheonGreeter.vala \
      --replace "/usr/bin/numlockx" "${numlockx}/bin/numlockx"
  '';

  preFixup = ''
    # So It gets the default gtk and icon themes
    gappsWrapperArgs+=(
      --prefix XDG_CONFIG_DIRS : "${elementary-default-settings}/etc"
      --prefix PATH : "${dbus}/bin"
    )
  '';

  postPatch = ''
    substituteInPlace src/PantheonGreeter.vala \
      --subst-var-by WINGPANEL_GREETER_EXEC "${wingpanel-with-indicators}/bin/wingpanel -g" \
      --subst-var-by GREETER_COMPOSITOR_EXEC "$out/bin/io.elementary.greeter-compositor"
  '';

  postFixup = ''
    substituteInPlace $out/share/xgreeters/io.elementary.greeter.desktop \
      --replace  "Exec=io.elementary.greeter" "Exec=$out/bin/io.elementary.greeter"

    substituteInPlace $out/etc/lightdm/io.elementary.greeter.conf \
      --replace "#default-wallpaper=/usr/share/backgrounds/elementaryos-default" "default-wallpaper=${elementary-wallpapers}/share/backgrounds/elementary/Pablo Garcia Saldana.jpg"
  '';

  meta = {
    description = "LightDM Greeter for Pantheon.";
  };
}
