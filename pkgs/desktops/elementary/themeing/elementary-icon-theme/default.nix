{ mkElementary, meson, python3,ninja, hicolor-icon-theme, gtk3 }:

mkElementary rec {
  pname = "icons";
  version = "1d23b93d70513cb8636864cf00ef0f27260d62d9";

  name = "elementary-icon-theme-2018-10-01";

  sha256 = "09s0wdby2k2adazyzd0xryxzxp3nwy09apvvma3azd7p9g147j4k";

  nativeBuildInputs = [
    meson
    ninja
    python3
  ];

  buildInputs = [ gtk3 ];

  propagatedBuildInputs = [ hicolor-icon-theme ];

  mesonFlags = [
    "-Dvolume_icons=false"
    "-Dpalettes=false"
  ];

  postPatch = ''
    chmod +x meson/symlink.py
    patchShebangs meson/symlink.py
  '';

  postFixup = "gtk-update-icon-cache $out/share/icons/elementary";

  meta = {
    description = "Named, vector icons for elementary OS";
    longDescription = ''
      An original set of vector icons designed specifically for elementary OS and its desktop environment: Pantheon.
    '';
  };
}
