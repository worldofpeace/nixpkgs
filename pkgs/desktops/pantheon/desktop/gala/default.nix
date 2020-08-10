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
  version = "unstable-2020-08-09";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "a85bae2f8a43d849d4a18baa20251c3cbc8389dc";
    sha256 = "J6OaLaDrkWN1Fk0F3j2CwolVSOkhcKNZP/grsvlS6rk=";
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
