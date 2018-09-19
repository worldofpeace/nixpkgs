{ mkElementary, makeWrapper, lib, meson, ninja, desktop-file-utils, glib, coreutils  }:

mkElementary rec {
  pname = "dpms-helper";
  version = "1.0";

  name = "elementary-${pname}-${version}";

  sha256 = "0svfp0qyb6nx4mjl3jx4aqmb4x24m25jpi75mdis3yfr3c1xz9nh";

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

  meta = {
    description = " Sets DPMS settings found in org.pantheon.dpms.";
  };
}
