{ stdenv, fetchFromGitHub, elementary, wrapGAppsHook, pkgconfig, meson, ninja
, vala, gala, gtk3, libgee, granite, gettext, appstream-glib, glib-networking
, mutter, json-glib, appstream, defaultIconTheme, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "wingpanel";
  version = "5fa1bd451fba38cbfab2866bef037801a00c6dfa";

  name = "${pname}-2018-10-15";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1q832q2rklm21a8agjmxp7nq9wk930l8d9qx5br00jrn0im3nvcx";
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
