{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson
, python3, ninja, vala, gtk3, granite, wingpanel, libnotify
, pulseaudio, libcanberra-gtk3, libgee, libxml2, wrapGAppsHook
, gobjectIntrospection, defaultIconTheme }:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-sound";
  version = "c74ff97fc2b30a09e0dbe53f22372672c9d838e1";

  name = "${pname}-2018-08-08";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0vvhjsg10yznh7gpqmg39hlrylrjqj3g93nn3bv5ihxl17dg124y";
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
