{ stdenv, fetchFromGitHub, elementary, wrapGAppsHook, pkgconfig, cmake, ninja
, vala, gala, gtk3, libgee, granite, gettext, appstream-glib, glib-networking
, mutter, json-glib, appstream, defaultIconTheme, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "wingpanel";
  version = "1bc406e7051bf94d90e74cebef949bac910e2622";

  name = "${pname}-2018-10-04";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0034x4bv54ys9fl4sw8jbfdgnliaw0lr8a5395793hs69dczknjm";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
  };

  nativeBuildInputs = [
    appstream
    appstream-glib
    cmake
    gettext
    glib-networking
    gobjectIntrospection
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

  patches = [ ./indicators.patch ./pkgconfig.patch ];

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
