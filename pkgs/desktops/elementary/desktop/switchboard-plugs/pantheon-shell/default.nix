{ mkElementary, meson, ninja, pkgconfig, vala, libgee, granite, gexiv2
, gnome-settings-daemon, glib, gtk3, gnome-desktop, plank, switchboard
, appstream-glib, gettext, gobjectIntrospection, bamf }:

mkElementary rec {
  pname = "switchboard-plug-pantheon-shell";
  version = "0.2.7";

  name = "${pname}-${version}";

  sha256 = "1lbc15da18z5qvqf22ghzrrs9mchmhb5mj0cmhxmwl5g651b6fk3";

  nativeBuildInputs = [
    appstream-glib
    gettext
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
    bamf
    gexiv2
    glib
    gnome-desktop
    gnome-settings-daemon
    granite
    gtk3
    libgee
    plank
    switchboard
  ];

  patches = [ ./backgrounds.patch ];

  # TODO: this needs tumbler https://github.com/elementary/switchboard-plug-pantheon-shell/commit/7887cbc0894f9cef49a2ba181290c3e0dd14bcef

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = {
    description = "Switchboard Desktop Plug";
  };
}