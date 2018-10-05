{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, python3, ninja, vala
, desktop-file-utils, gtk3, granite, libgee, gcr, webkitgtk, gobjectIntrospection, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "capnet-assist";
  version = "2e49e2c39b9b0bd979bc5219a9350a4dfd6c6292";

  name = "elementary-${pname}-2018-10-05";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0cnra33i5h6b2rgp0d6q4gr3d5cd1d0pjj055wn6p0b2n82jlbsf";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
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
    gcr
    granite
    gtk3
    libgee
    webkitgtk
  ];

  # Not useful here or in elementary - See: https://github.com/elementary/capnet-assist/issues/3
  patches = [ ./capnet-test.patch ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "A small WebKit app that assists a user with login when a captive portal is detected";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
