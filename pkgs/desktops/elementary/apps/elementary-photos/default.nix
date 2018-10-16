{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig, vala, desktop-file-utils
, intltool, gtk3, glib, libaccounts-glib, libexif, libgee, geocode-glib, gexiv2,libgphoto2
, granite, gst_all_1, libgudev, json-glib, libraw, rest, libsoup, sqlite
, scour, webkitgtk, libwebp, appstream, libunity, wrapGAppsHook, gobjectIntrospection, defaultIconTheme }:

stdenv.mkDerivation rec {
  pname = "photos";
  version = "2.6.0";

  name = "elementary-${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1lf5mm9909khf2jy3jhzlm725yf23biylxn15h6synrh7g3gzfqx";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-${pname}";
    };
  };

  nativeBuildInputs = [
    appstream
    desktop-file-utils
    gobjectIntrospection
    intltool
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = with gst_all_1; [
    defaultIconTheme
    geocode-glib
    gexiv2
    granite
    gst-plugins-bad
    gst-plugins-base
    gst-plugins-good
    gst-plugins-ugly
    gstreamer
    gtk3
    json-glib
    libaccounts-glib
    libexif
    libgee
    libgphoto2
    libgudev
    libraw
    libsoup
    libunity
    libwebp
    rest
    scour
    sqlite
    webkitgtk
  ];

  mesonFlags = [
    "-Dplugins=false"
  ];

  # This should be provided by a post_install.py script
  postInstall = ''
    ${glib.dev}/bin/glib-compile-schemas $out/share/glib-2.0/schemas
  '';

  meta =  with stdenv.lib; {
    description = "Photo viewer and organizer designed for elementary OS";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
