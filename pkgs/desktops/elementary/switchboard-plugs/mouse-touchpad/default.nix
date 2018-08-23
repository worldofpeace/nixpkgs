{ mkElementary, fetchpatch, meson, ninja, pkgconfig, vala, libgee, granite
, glib, gtk3, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-mouse-touchpad";
  version = "0.1.3";

  name = "${pname}-${version}";

  sha256 = "1d91simqd4likx3lg3fi9bbiajkq4f95i3446nzqriy33m5g3yb2";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
    glib
    granite
    gtk3
    libgee
    switchboard
  ];

  # Fixes https://github.com/elementary/switchboard-plug-mouse-touchpad/issues/36
  patches = [
    (fetchpatch {
      url = "https://github.com/elementary/switchboard-plug-mouse-touchpad/commit/c54e7468cf65dba4d0e31cb8bcf182063d9d924e.patch";
      sha256 = "1izm3c69ibgn65f55irlf6jkrzym61yzhr75z5nqi9hw5jbcyncy";
    })
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = {
    description = "Switchboard Mouse & Touchpad Plug";
  };

}