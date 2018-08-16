{ mkElementary, meson, ninja, hicolor-icon-theme, gtk3 }:

mkElementary rec {
  pname = "icons";
  version = "ee6a3fc5862dfea7ab4c91049a4f6ede82ea8954";

  name = "elementary-icon-theme-2018-08-16";

  sha256 = "1xysvnwlkmapnvcacfl4ncbxvil6drrn3pjqs5p1rjg2mfcbbzgh";

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
