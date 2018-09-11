{ mkElementary, pkgconfig, fetchpatch, meson, ninja
, vala, desktop-file-utils, gtk3, libxml2, granite, libnotify, vte
, libgee, defaultIconTheme, appstream, gobjectIntrospection, wrapGAppsHook }:

mkElementary rec {
  pname = "terminal";
  version = "0.5.3";

  name = "elementary-${pname}-${version}";

  sha256 = "1vrwnd5cp0mr5jg66fds3s37v7cl4vsyxrn67iy9jsvyaklmh8yb";

  nativeBuildInputs = [
    appstream
    desktop-file-utils
    gobjectIntrospection
    libxml2
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    defaultIconTheme
    granite
    gtk3
    libgee
    libnotify
    vte
  ];

  # See https://github.com/elementary/terminal/commit/914d4b0e2d0a137f12276d748ae07072b95eff80
  mesonFlags = "-Dubuntu-bionic-patched-vte=false";

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Terminal emulator designed for elementary OS";
    longDescription = ''
      A super lightweight, beautiful, and simple terminal. Comes with sane defaults, browser-class tabs, sudo paste protection,
      smart copy/paste, and little to no configuration.
    '';
  };
}
