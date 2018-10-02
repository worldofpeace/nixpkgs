{ mkElementary, pkgconfig, fetchpatch, substituteAll, makeWrapper, meson
, ninja, vala, desktop-file-utils, gtk3, granite, libgee, elementary-settings-daemon
, gnome-desktop, mutter, gobjectIntrospection, defaultIconTheme, wingpanel-with-indicators
, elementary-gtk-theme, nixos-artwork, elementary-default-settings
, lightdm, numlockx, clutter-gtk, libglvnd, dbus, wrapGAppsHook }:

mkElementary rec {
  pname = "greeter";
  version = "23f1750ac6c25c7ea8581df71d75d946cd8e7773";

  name = "elementary-${pname}-2018-09-24";

  sha256 = "07xdl8wy78hv3yl8m46rxn9c2y93z03zl8fv826x4j7jlfaqq721";

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
    elementary-settings-daemon
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
      elementary-settings-daemon = "${elementary-settings-daemon}/libexec";
    })
    ./01-sbin-bin.patch
    ./01-sysconfdir-install.patch
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
    gappsWrapperArgs+=(
      # GTK+ reads default settings (such as icons and themes) from elementary's settings.ini here
      --prefix XDG_CONFIG_DIRS : "${elementary-default-settings}/etc"

      # dbus-launch needed in path
      --prefix PATH : "${dbus}/bin"

      # for `wingpanel -g`
      --prefix PATH : "${wingpanel-with-indicators}/bin"

      # TODO: they should be using meson for this
      # See: https://github.com/elementary/greeter/blob/19c0730fded4e9ddec5a491f0e78f83c7c04eb59/src/PantheonGreeter.vala#L451
      --prefix PATH : "$out/bin"
    )
  '';

  postFixup = ''
    substituteInPlace $out/share/xgreeters/io.elementary.greeter.desktop \
      --replace  "Exec=io.elementary.greeter" "Exec=$out/bin/io.elementary.greeter"

    substituteInPlace $out/etc/lightdm/io.elementary.greeter.conf \
      --replace "#default-wallpaper=/usr/share/backgrounds/elementaryos-default" "default-wallpaper=${nixos-artwork.wallpapers.simple-dark-gray}/share/artwork/gnome/nix-wallpaper-simple-dark-gray.png"
  '';

  meta = {
    description = "LightDM Greeter for Pantheon.";
  };
}
