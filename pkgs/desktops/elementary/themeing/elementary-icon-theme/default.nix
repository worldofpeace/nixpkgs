{ mkElementary, meson, ninja, hicolor-icon-theme, gtk3 }:

mkElementary rec {
  pname = "icons";
  version = "95571d659b82d354bcebe9b7e229c8a2f2eb7ac5";

  name = "elementary-icon-theme-2018-09-08";

  sha256 = "1rzqawcrk5p42xcwj1k9cx7dxnb33knm8mw0q11wnzv56s2hmcqj";

  nativeBuildInputs = [
    meson
    ninja
  ];

  buildInputs = [ gtk3 ];

  propagatedBuildInputs = [ hicolor-icon-theme ];

  mesonFlags = [
    "-D volume_icons=false"
    "-D palettes=false"
  ];

  postPatch = ''
    chmod +x ./meson/symlink.py
    patchShebangs ./meson/symlink.py
  '';

  postFixup = "gtk-update-icon-cache $out/share/icons/elementary";

  meta = {
    description = "Named, vector icons for elementary OS";
    longDescription = ''
      An original set of vector icons designed specifically for elementary OS and its desktop environment: Pantheon.
    '';
  };
}
