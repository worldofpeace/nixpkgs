{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, meson
, ninja
, pkg-config
, vala
, python3
, gtk3
, desktop-file-utils
, glib
, granite
, libgee
, dbus
, accountsservice
, geoclue2
, wrapGAppsHook
}:

stdenv.mkDerivation rec {
  pname = "pantheon-settings-daemon";
  version = "unstable-2020-09-29";

  repoName = "settings-daemon";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = "b61f3ff268d995368b3f728b51828e54d76fe0f6";
    hash = "sha256-EJHvFARpMPHJ43hrNAhUVHrkDndPsS5y1znFatzARmw=";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    desktop-file-utils # update-desktop-database
    glib # glib-compile-schemas
    gtk3 # gtk-update-icon-cache
    meson
    ninja
    pkg-config
    python3
    vala
    wrapGAppsHook # TODO: make wrapGAppsHookNoGui
  ];

  buildInputs = [
    accountsservice
    dbus
    geoclue2
    glib
    granite
    libgee
  ];

  postPatch = ''
    patchShebangs meson/create-symlink.sh meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Settings daemon for Pantheon";
    homepage = "https://github.com/elementary/settings-daemon";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
