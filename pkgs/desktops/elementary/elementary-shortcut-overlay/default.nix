{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, ninja, vala, libxml2, desktop-file-utils
, gtk3, glib, granite, libgee, defaultIconTheme, gobjectIntrospection, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "shortcut-overlay";
  version = "f2e9cdd1d6073cc0265b3c8e574cbea65163308c";

  name = "elementary-${pname}-2018-08-21";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "07a9lc6zx7vsjryqbrqdlj0qnxclad6fs4rb7q122laxnsy0sjzg";
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
