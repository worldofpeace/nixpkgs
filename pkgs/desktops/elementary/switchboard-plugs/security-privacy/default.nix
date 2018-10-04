{ stdenv, fetchFromGitHub, elementary, meson, python3, ninja
, pkgconfig, vala, libgee, granite, gtk3, polkit, zeitgeist
, switchboard, lightlocker, pantheon-agent-geoclue2, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-security-privacy";
  version = "51421379d2b0739c74d6b7233627e4dbe4c55f9b";

  name = "${pname}-2018-06-25";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1jwrriqwxfv4z8rfw6m85sgc3wfcmfy5g8khc8w1af9r0l2cm79w";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
  };

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    python3
    vala
  ];

  buildInputs = [
    granite
    gtk3
    libgee
    polkit
    switchboard
    zeitgeist
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  patches = [
    ./hardcode-gsettings.patch
    ./hardcode-lightlocker-gsettings.patch
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py

    substituteInPlace src/Views/LockPanel.vala --subst-var-by LIGHTLOCKER_GSETTINGS_PATH ${lightlocker}/share/gsettings-schemas/${lightlocker.name}/glib-2.0/schemas
    substituteInPlace src/Views/FirewallPanel.vala --subst-var-by SWITCHBOARD_SEC_PRIV_GSETTINGS_PATH $out/share/gsettings-schemas/${name}/glib-2.0/schemas
  '';

  meta = with stdenv.lib; {
    description = "Switchboard Security & Privacy Plug ";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };

}
