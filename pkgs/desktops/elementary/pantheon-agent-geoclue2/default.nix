{ mkElementary, pkgconfig, meson, ninja, vala, glib
, gtk3, libgee, desktop-file-utils, dbus-glib, geoclue2, gobjectIntrospection, wrapGAppsHook }:

mkElementary rec {
  pname = "pantheon-agent-geoclue2";
  version = "1.0";

  name = "${pname}-${version}";

  sha256 = "0m7wbyqqivfwpd2m4jcxg4vl3vmfxkj7285h283p9m6nfh9vz960";

  nativeBuildInputs = [
    desktop-file-utils
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
   ];

  buildInputs = [
    dbus-glib
    geoclue2
    glib
    gtk3
    libgee
   ];

   patches = [
     ./hardcode-gsettings.patch
   ];

  postPatch = ''
    substituteInPlace src/Agent.vala --subst-var-by PANTHEON_AGENT_GEOCLUE2_GSETTINGS_PATH $out/share/gsettings-schemas/${name}/glib-2.0/schemas
  '';

  # This should be provided by a post_install.py script
  postInstall = ''
    ${glib.dev}/bin/glib-compile-schemas $out/share/glib-2.0/schemas
  '';

  meta = {
    description = "Pantheon Geoclue2 Agent";
  };
}