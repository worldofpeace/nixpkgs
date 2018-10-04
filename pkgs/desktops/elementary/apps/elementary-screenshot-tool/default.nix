{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson
, ninja, vala, python3, desktop-file-utils, gtk3, granite
, libgee, libcanberra, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "screenshot-tool"; # This will be renamed to "screenshot" soon. See -> https://github.com/elementary/screenshot/pull/93
  version = "bbe21a949e90c34fdd3537e52033957a3d9a59e2";

  name = "elementary-${pname}-2018-10-01";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = "screenshot";
    rev = version;
    sha256 = "1ll341bbsjzax7a02jmg7472bw9b7dh0pk8qadjysa11b87kcklw";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = "screenshot";
      attrPath = "elementary-${pname}";
    };
  };

  nativeBuildInputs = [
    desktop-file-utils
    gobjectIntrospection
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
    libcanberra
    libgee
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Screenshot tool designed for elementary OS";
    homepage = "https://github.com/elementary/screenshot";
    license = licenses.lgpl3;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
