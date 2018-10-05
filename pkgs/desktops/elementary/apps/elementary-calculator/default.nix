{ stdenv, fetchFromGitHub, elementary, pkgconfig
, meson, ninja, vala, desktop-file-utils, libxml2
, gtk3, python3, granite, libgee, gobjectIntrospection
, defaultIconTheme, appstream, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "calculator";
  version = "3a0176331119fa6bcd92749f4ad28b09f7b80c77";

  name = "elementary-${pname}-2018-10-05";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1y87ra3spl6qd59nwvqmbpih6i9ya6s42l8dp4ycpz9wf6pmxmxp";
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
    libxml2
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    defaultIconTheme
    granite
    gtk3
    libgee
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    homepage = "https://github.com/elementary/${pname}";
    description = "Calculator app designed for elementary OS";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
