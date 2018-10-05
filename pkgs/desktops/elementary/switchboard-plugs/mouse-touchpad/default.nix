{ stdenv, fetchFromGitHub, elementary, fetchpatch, meson, ninja
, pkgconfig, vala, libgee, granite, gtk3, switchboard, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-mouse-touchpad";
  version = "84eb7078b118fe513b276ab5365a8f4242004d86";

  name = "${pname}-2018-09-19";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "007dg0klr0v7fjiq658kybwdc2w10yygizlq6wcjh1df3y6kbris";
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
    gtk3
    libgee
    switchboard
  ];

  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  meta = with stdenv.lib; {
    description = "Switchboard Mouse & Touchpad Plug";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
