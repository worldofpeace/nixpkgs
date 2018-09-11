{ mkElementary, meson, ninja, pkgconfig, vala, libgee, granite
, gexiv2, gnome-settings-daemon, gtk3, gnome-desktop, plank
, switchboard, appstream-glib, gettext, gobjectIntrospection, bamf }:

mkElementary rec {
  pname = "switchboard-plug-pantheon-shell";
  version = "bbdcdb7112ed549aa073a7f26a9afff98325c8e0";

  name = "${pname}-2018-09-08";

  sha256 = "1m3lvdmvi9qblf6ryafn8pkw8labixii2am0v87na49ssmwch8va";

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
