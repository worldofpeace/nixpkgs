{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, python3, ninja, vala
, desktop-file-utils, gtk3, granite, libgee, gcr, webkitgtk, gobjectIntrospection, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "capnet-assist";
  version = "0.2.2";

  name = "elementary-${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "03v1crayzgdwr16wq7xlqn2p5nmd8d9xm7qjxm8r76n9ika6xp80";
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
