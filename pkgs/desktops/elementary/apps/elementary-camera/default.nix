{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, python3, gettext, libxml2, gtk3, granite, libgee
, libcanberra, clutter-gtk, clutter-gst, defaultIconTheme, appstream, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "camera";
  version = "65562711c96651dddf6eb5b94e3921f21837beab";

  name = "elementary-${pname}-2018-10-05";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "05hq9ga0zqszvlqyq6l9rdhjxs8dak34mjixngwflk3sir4dqs51";
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
    gettext
    libxml2
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    clutter-gst
    clutter-gtk
    defaultIconTheme
    granite
    gtk3
    libcanberra
    libgee
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Camera app designed for elementary OS";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
