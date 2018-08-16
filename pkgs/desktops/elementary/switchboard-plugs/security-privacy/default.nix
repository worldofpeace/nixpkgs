{ mkElementary, meson, ninja, pkgconfig, vala, libgee, granite
, glib, gtk3, polkit, zeitgeist, gsettings-desktop-schemas, switchboard, lightlocker
, pantheon-agent-geoclue2, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-security-privacy";
  version = "0.1.3";

  name = "${pname}-${version}";

  sha256 = "0zzllcgw18z0w2h82mxqihbbdrshxmq7zsp38n5gl3b818ikfkpl";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
    glib
    granite
    gsettings-desktop-schemas
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
    ./hardcode-location-gsettings.patch
  ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py

    substituteInPlace src/Views/LockPanel.vala --subst-var-by LIGHTLOCKER_GSETTINGS_PATH ${lightlocker}/share/gsettings-schemas/${lightlocker.name}/glib-2.0/schemas
    substituteInPlace src/Views/LocationPanel.vala --subst-var-by PANTHEON_AGENT_GEOCLUE2_GSETTINGS_PATH ${pantheon-agent-geoclue2}/share/gsettings-schemas/${pantheon-agent-geoclue2.name}/glib-2.0/schemas
    substituteInPlace src/Views/FirewallPanel.vala --subst-var-by SWITCHBOARD_SEC_PRIV_GSETTINGS_PATH $out/share/gsettings-schemas/${name}/glib-2.0/schemas
  '';

  meta = {
    description = "Switchboard Security & Privacy Plug ";
  };

}