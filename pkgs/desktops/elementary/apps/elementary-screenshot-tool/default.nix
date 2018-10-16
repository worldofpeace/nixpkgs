{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson
, ninja, vala, python3, desktop-file-utils, gtk3, granite
, libgee, libcanberra, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

let

redacted-script = stdenv.mkDerivation rec {
  name = "elementary-redacted-script";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = "fonts";
    rev = version;
    sha256 = "16x2w7w29k4jx2nwc5932h9rqvb216vxsziazisv2rpll74kn8b2";
  };

  dontConfigure = true;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/redacted-elementary
    cp -a redacted/*.ttf $out/share/fonts/truetype/redacted-elementary
  '';

  meta = with stdenv.lib; {
    description = "Redacted Script Font for elementary";
    homepage = https://github.com/elementary/fonts;
    license = licenses.ofl;
    maintainers = elementary.maintainers;
    platforms = platforms.linux;
  };
};

in

stdenv.mkDerivation rec {
  pname = "screenshot-tool"; # This will be renamed to "screenshot" soon. See -> https://github.com/elementary/screenshot/pull/93
  version = "1.6.0";

  name = "elementary-${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = "screenshot";
    rev = version;
    sha256 = "0hxgh7br12kw8bs2cdm2q9ivhnj2zb0i7fs43pkgf3z0fidjf1yv";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = "screenshot";
      attrPath = "elementary-${pname}";
    };
  };

  nativeBuildInputs = [
    desktop-file-utils
    gobjectIntrospection
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
    libcanberra
    libgee
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  postInstall = ''
    mkdir -p $out/share/fonts/truetype
    cp -rva ${redacted-script}/share/fonts/truetype/redacted-elementary $out/share/fonts/truetype
  '';

  meta = with stdenv.lib; {
    description = "Screenshot tool designed for elementary OS";
    homepage = "https://github.com/elementary/screenshot";
    license = licenses.lgpl3;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
