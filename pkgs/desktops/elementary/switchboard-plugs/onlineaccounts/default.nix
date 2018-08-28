{ mkElementary, cmake, pkgconfig, vala, libgee, granite
, gtk3, libaccounts-glib, libgsignon-glib, gsignond, json-glib
, rest, webkitgtk, libsoup, switchboard, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard-plug-onlineaccounts";
  version = "4d9120feb9f4b8464e8bc3c3aa68be682fbded99";

  name = "${pname}-2018-07-22";

  sha256 = "1a0jf9im2450fms8p0rpsnqsq36rj0fg0sxg2x31ihjii3sn9mlz";

  nativeBuildInputs = [
    cmake
    gobjectIntrospection
    pkgconfig
    vala
  ];

  buildInputs = [
    granite
    gsignond
    gtk3
    json-glib
    libaccounts-glib
    libgee
    libgsignon-glib
    libsoup
    rest
    switchboard
    webkitgtk
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = {
    description = "Switchboard Online Accounts Plug";
  };

}