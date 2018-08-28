{ mkElementary, pkgconfig, meson, ninja, vala, gtk3
, libgee, polkit, gobjectIntrospection, wrapGAppsHook }:

mkElementary rec {
  pname = "pantheon-agent-polkit";
  version = "0.1.5";

  name = "${pname}-${version}";

  sha256 = "12aq47s0xgqwfi9hd6n653ysrjn580mi3ypfnn2xp7awbs30s650";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    gtk3
    libgee
    polkit
  ];

  meta = {
    description = "Polkit Agent for the Pantheon Desktop.";
  };
}
