{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson
, python3, ninja, vala, gtk3, granite, wingpanel, libnotify
, pulseaudio, libcanberra-gtk3, libgee, libxml2, wrapGAppsHook
, gobjectIntrospection, defaultIconTheme }:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-sound";
  version = "74b7425e29df98971dce413295f0ccf7dc53c965";

  name = "${pname}-2018-10-01";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "086z4d0bgnarpxflcjkp1l1n00q4087xzja9r3dkdz535py55k93";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
  };

  nativeBuildInputs = [
    gobjectIntrospection
    libxml2
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    defaultIconTheme
    granite
    gtk3
    libcanberra-gtk3
    libgee
    libnotify
    pulseaudio
    wingpanel
  ];

  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Sound Indicator for Wingpanel";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
