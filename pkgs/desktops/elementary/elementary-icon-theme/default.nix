{ mkElementary, meson, ninja, hicolor-icon-theme, gtk3 }:

mkElementary rec {
  pname = "icons";
  version = "d8a8d41eef2acc43f426d9d7b14022121a09ed97";

  name = "elementary-icon-theme-2018-06-20";

  sha256 = "0kndzsb1hxpis7lrqimspwzmn9s6qj0llqv6lr0vcvzbznm6fagf";

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
