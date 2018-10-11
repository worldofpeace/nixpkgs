{ stdenv, fetchFromGitHub, elementary, wrapGAppsHook, pkgconfig, meson, ninja
, vala, gala, gtk3, libgee, granite, gettext, appstream-glib, glib-networking
, mutter, json-glib, appstream, defaultIconTheme, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "wingpanel";
  version = "fd0ebe1d7639487ac99eff2a994c8a178305fc32";

  name = "${pname}-2018-10-11";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1bj2b3m9jdi6vhxyywgqc0md2dcv1105rd8mrmv271snkzf9xkx9";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
  };

  nativeBuildInputs = [
    appstream
    appstream-glib
    gettext
    glib-networking
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    gala
    granite
    gtk3
    json-glib
    libgee
    mutter
  ];

  patches = [ ./indicators.patch ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "The extensible top panel for Pantheon";
    longDescription = ''
      Wingpanel is an empty container that accepts indicators as extensions,
      including the applications menu.
    '';
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
