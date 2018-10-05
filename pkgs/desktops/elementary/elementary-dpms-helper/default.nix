{ stdenv, fetchFromGitHub, elementary, makeWrapper, lib, meson, ninja, desktop-file-utils, glib, coreutils }:

stdenv.mkDerivation rec {
  pname = "dpms-helper";
  version = "e2547fdb3cfb695cd0e34511c43e3750602d5d0b";

  name = "elementary-${pname}-2018-05-18";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0svfp0qyb6nx4mjl3jx4aqmb4x24m25jpi75mdis3yfr3c1xz9nh";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-${pname}";
    };
  };

  nativeBuildInputs = [
    desktop-file-utils
    glib
    makeWrapper
    meson
    ninja
  ];

  postFixup = ''
    substituteInPlace $out/etc/xdg/autostart/io.elementary.dpms-helper.desktop \
      --replace "Exec=io.elementary.dpms-helper" "Exec=$out/bin/io.elementary.dpms-helper"

    wrapProgram $out/bin/io.elementary.dpms-helper \
      --prefix PATH ":" "${lib.makeBinPath [ glib.dev coreutils ]}"
  '';

  postInstall = ''
    ${glib.dev}/bin/glib-compile-schemas $out/share/glib-2.0/schemas
  '';

  meta = with stdenv.lib; {
    description = "Sets DPMS settings found in org.pantheon.dpms";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
