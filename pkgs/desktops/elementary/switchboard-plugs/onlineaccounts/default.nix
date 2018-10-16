{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig, vala
, libgee, granite, gtk3, libaccounts-glib, libsignon-glib, gsignond
, json-glib, rest, webkitgtk, libsoup, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-onlineaccounts";
  version = "2.0";

  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "19q2i0nvxqsca0r4a3rg89zm8r0c5z9h5g2n8l88n8if24rsjj0k";
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
