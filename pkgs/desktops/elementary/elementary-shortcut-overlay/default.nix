{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, ninja, vala, libxml2, desktop-file-utils
, gtk3, glib, granite, libgee, defaultIconTheme, gobjectIntrospection, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "shortcut-overlay";
  version = "0a0a718df213010ca7e47399ed81aad86dd98433";

  name = "elementary-${pname}-2018-09-25";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "016zcwwqbl5020xfxgbdg0n3llg53zcx209hjb7wcdwdzm9h525p";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-${pname}";
    };
  };

  nativeBuildInputs = [
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
    glib
    granite
    gtk3
    libgee
  ];

  meta = with stdenv.lib; {
    description = "A native OS-wide shortcut overlay to be launched by Gala";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
