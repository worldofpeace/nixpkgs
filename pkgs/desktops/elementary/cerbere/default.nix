{ mkElementary, pkgconfig, meson, ninja, glib, libgee, vala, gsettings-desktop-schemas, gobjectIntrospection }:

mkElementary rec {
  pname = "cerbere";
  version = "0.2.3";

  name = "${pname}-${version}";

  sha256 = "1na6cy79h5mkd92ia3kd66nwmhqb1jimhz52sv13hii5p0770chp";

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [ glib gsettings-desktop-schemas libgee ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py    
  '';

  meta = {
    description = "A simple service to ensure uptime of essential processes";
  };
}
