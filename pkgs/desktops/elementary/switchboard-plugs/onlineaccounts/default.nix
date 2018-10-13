{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig, vala
, libgee, granite, gtk3, libaccounts-glib, libsignon-glib, gsignond
, json-glib, rest, webkitgtk, libsoup, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-onlineaccounts";
  version = "76df4d61ac24b5f78ac24441a269412cadeef89d";

  name = "${pname}-2018-10-12";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "18rgr8sa1glm8636x383x2q4r840gxgwszxk8p5yj8480n3a6liy";
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
    vala
  ];

  buildInputs = [
    granite
    gsignond
    gtk3
    json-glib
    libaccounts-glib
    libgee
    libsignon-glib
    libsoup
    rest
    switchboard
    webkitgtk
  ];

  PKG_CONFIG_LIBACCOUNTS_GLIB_PROVIDERFILESDIR = "${placeholder "out"}/share/accounts/providers";
  PKG_CONFIG_LIBACCOUNTS_GLIB_SERVICEFILESDIR = "${placeholder "out"}/share/accounts/services";
  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "${placeholder "out"}/lib/switchboard";


  meta = with stdenv.lib; {
    description = "Switchboard Online Accounts Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };

}
