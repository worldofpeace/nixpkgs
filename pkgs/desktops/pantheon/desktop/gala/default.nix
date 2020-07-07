{ lib, stdenv
, fetchFromGitHub
, nix-update-script
, fetchpatch
, pantheon
, pkg-config
, meson
, python3
, ninja
, vala
, desktop-file-utils
, gettext
, libxml2
, gtk3
, granite
, libgee
, bamf
, libcanberra
, libcanberra-gtk3
, gnome-desktop
, mutter
, clutter
, elementary-dock
, elementary-icon-theme
, elementary-settings-daemon
, wrapGAppsHook
}:

stdenv.mkDerivation rec {
  pname = "gala";
  version = "unstable-2020-07-04";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "20d9eaebbe35f8ec72529e1954e665c90e90d0e5";
    sha256 = "060x333mvvsrha2w4j1n9f77azb050f5pj4pzj23pbdjwy9i6ch7";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    desktop-file-utils
    gettext
    libxml2
    meson
    ninja
    pkg-config
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    bamf
    clutter
    elementary-dock
    elementary-icon-theme
    elementary-settings-daemon
    gnome-desktop
    granite
    gtk3
    libcanberra
    libcanberra-gtk3
    libgee
    mutter
  ];

  patches = [
    # https://github.com/elementary/gala/pull/869
    # build failure in vala 0.48.7
    # https://github.com/elementary/gala/pull/869#issuecomment-657147695
    (fetchpatch {
      url = "https://github.com/elementary/gala/commit/85d290c75eaa147b704ad34e6c67498071707ee8.patch";
      sha256 = "19jkvmxidf453qfrxkvi35igxzfz2cm8srwkabvyn9wyd1yhiw0l";
    })
    ./plugins-dir.patch
  ];

  postPatch = ''
    chmod +x build-aux/meson/post_install.py
    patchShebangs build-aux/meson/post_install.py
  '';

  meta =  with lib; {
    description = "A window & compositing manager based on mutter and designed by elementary for use with Pantheon";
    homepage = "https://github.com/elementary/gala";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
