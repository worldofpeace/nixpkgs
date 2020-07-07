{ lib, stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, meson
, python3
, ninja
, pkg-config
, vala
, libgee
, granite
, gtk3
, glib
, polkit
, zeitgeist
, switchboard
, gala
, gsettings-desktop-schemas
}:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-security-privacy";
  version = "unstable-2020-06-09";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "b32d5553e0dbdd02eb6895e672da7ec18fad3ea1";
    sha256 = "0sq6bamagnlqnj0sy2s8s3qlyv3l29ag08r3gwg4jjzd2b9310pn";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    python3
    vala
  ];

  buildInputs = [
    gala
    glib
    granite
    gsettings-desktop-schemas
    gtk3
    libgee
    polkit
    switchboard
    zeitgeist
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with lib; {
    description = "Switchboard Security & Privacy Plug";
    homepage = "https://github.com/elementary/switchboard-plug-security-privacy";
    license = licenses.lgpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };

}
