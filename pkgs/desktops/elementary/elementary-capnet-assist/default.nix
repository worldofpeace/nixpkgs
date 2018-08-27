{ mkElementary, pkgconfig, meson, ninja, vala, desktop-file-utils, gtk3, granite, libgee, gcr, webkitgtk, gobjectIntrospection, wrapGAppsHook }:

mkElementary rec {
  pname = "capnet-assist";
  version = "0.2.2";

  name = "elementary-${pname}-${version}";

  sha256 = "03v1crayzgdwr16wq7xlqn2p5nmd8d9xm7qjxm8r76n9ika6xp80";

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
    gcr
    granite
    gtk3
    libgee
    webkitgtk
  ];

  # Not useful here or in elementary - See: https://github.com/elementary/capnet-assist/issues/3
  patches = [ ./capnet-test.patch ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "A small WebKit app that assists a user with login when a captive portal is detected";
  };
}